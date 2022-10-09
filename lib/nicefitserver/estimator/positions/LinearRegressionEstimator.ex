defmodule Nicefitserver.Estimator.Positions.LinearRegressionEstimator do
  import Nx.Defn

  defn predict({coef_height, coef_weight, coef_age, bias}, {height, weight, age}) do
    coef_height * height + coef_weight * weight + coef_age * age + bias
  end

  defn loss(params, x, y) do
    y_pred = predict(params, x)
    Nx.mean(Nx.power(y - y_pred, 2))
  end

  defn update({coef_height, coef_weight, coef_age, bias} = params, inp, tar) do
    {grad_coef_height, grad_coef_weight, grad_coef_age, grad_bias} =
      grad(params, &loss(&1, inp, tar))

    {
      coef_height - grad_coef_height * 0.01,
      coef_weight - grad_coef_weight * 0.01,
      coef_age - grad_coef_age * 0.01,
      bias - grad_bias * 0.01
    }
  end

  def inner_train(data, epochs) do
    init_params = {0.5, 0.5, 0.5, 0.5}

    for _ <- 1..epochs, reduce: init_params do
      acc ->
        data
        |> Enum.take(Enum.count(data))
        |> Enum.reduce(
          acc,
          fn batch, cur_params ->
            i = Kernel.elem(batch, 0)
            height = Nx.tensor(Kernel.elem(i, 0) / 4_000)
            weight = Nx.tensor(Kernel.elem(i, 1) / 200)
            age = Nx.tensor(Kernel.elem(i, 2) / 150)
            x = {height, weight, age}
            y = Nx.tensor(Kernel.elem(batch, 1) / 2000)
            update(cur_params, x, y)
          end
        )
    end
  end

  def train(data, epochs) do
    {h, w, a, b} = inner_train(data, epochs)
    {Nx.to_number(h), Nx.to_number(w), Nx.to_number(a), Nx.to_number(b)}
  end

  def calc(h, w, a, params) do
    Kernel.trunc(
      (h / 4_000 * elem(params, 0) + w / 200 * elem(params, 1) + a / 150 * elem(params, 2) +
         elem(params, 3)) * 2_000
    )
  end
end
