defmodule Nicefitserver.Estimator.Estimate do
  alias Nicefitserver.Estimator.Positions.LinearRegressionEstimator
  alias Nicefitserver.Estimator.Positions.KNNEstimator
  alias Nicefitserver.Repository.Position, as: Position
  alias Nicefitserver.Repository.Attribute, as: Attribute
  require Logger

  use GenServer

  # @epochs 200
  # @users_limit 1000

  @epochs 10
  @users_limit 200

  @name __MODULE__

  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    exec_retrain()
  end

  def train_gender_position(users, gender, position_name) do
    filtered_gender =
      Enum.filter(users, fn e ->
        Attribute.findIn(e, "Gender").value == gender
      end)

    filtered_position =
        Enum.filter(filtered_gender, fn e ->
          Position.findIn(e, position_name) != nil
    end)
    data =
      Enum.map(filtered_position, fn u ->
        height = Position.findIn(u, "Height").value
        weight = Position.findIn(u, "Weight").value
        age = String.to_integer(Attribute.findIn(u, "Age").value)
        position = Position.findIn(u, position_name).value
        {{height, weight, age}, position}
      end)

    {LinearRegressionEstimator.train(data, @epochs), KNNEstimator.train(data, @epochs)}
  end

  @impl GenServer
  def handle_call({:estimate_body, g, h, w, a}, _from, state) do
    results = case g do
      "male" ->
        Enum.map(state, fn p ->
          %{:position => p.position, :value => (
            LinearRegressionEstimator.calc(h, w, a, elem(p.estimator_male,0)) +
            KNNEstimator.calc(h, w, a, elem(p.estimator_male, 1))) /2}
        end)
      "female" ->
        Enum.map(state, fn p ->
          %{:position => p.position, :value => (
            LinearRegressionEstimator.calc(h, w, a, elem(p.estimator_male,0)) +
            KNNEstimator.calc(h, w, a, elem(p.estimator_male, 1))) /2}
        end)
      end
    {:reply , results, state}
  end

  def handle_call({:retrain}, _from, _state) do
    {:ok, state} = exec_retrain()
    {:reply , {}, state}
  end

  def exec_retrain() do
    users = Nicefitserver.Repository.User.load(%{limit: @users_limit})
    positions_source = Position.load()
    positions = Enum.filter(positions_source, fn p ->
      p.dimensions == 3
    end)
    Logger.info("Training...")
    estimators = Enum.map(positions, fn p ->
      Logger.info("Training " <> p.name)
      Logger.info("Training Male/" <> p.name)
      estimators_male = train_gender_position(users, "male", p.name)
      Logger.info("Training Female/" <> p.name)
      estimators_female = train_gender_position(users, "female", p.name)
      Logger.info("Ready " <> p.name)
      %{:position => p.name, :estimator_male => estimators_male, :estimator_female => estimators_female}
    end)
    Logger.info("Finished Training")
    {:ok, estimators}
  end

  def retrain() do
    GenServer.call(@name, {:retrain})
  end

  def retrain({:async}) do
    Task.async(fn -> GenServer.call(@name, {:retrain},:infinity) end)
  end

  def estimate(g, h, w, a) do
    res = GenServer.call(@name, {:estimate_body, g, h, w, a})
    IO.inspect(res)
  end
end
