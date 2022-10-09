defmodule Nicefitserver.Recommender.Recommend do
  alias Nicefitserver.Repository.User
  alias Nicefitserver.Repository.Product
  alias Nicefitserver.Repository.Position
  alias Nicefitserver.Repository.Attribute
  alias Nicefitserver.Recommender.Recommendation

  @max_distance 80

  def recommend_variant(%{:method => "geometric", :user => user, :product => product}) do
    %product_type{} = product
    %user_type{} = user
    user_gender = Attribute.findIn(user, "Gender")
    product_gender = Attribute.findIn(product, "Gender")
    case String.upcase(user_gender.value) == String.upcase(product_gender.value) do
      false ->
        {:error}

      true ->
        case product_type do
          Product ->
            case user_type do
              User ->
                height = Position.findIn(user, "Height").value
                weight = Position.findIn(user, "Weight").value
                age = String.to_integer(Attribute.findIn(user, "Age").value)
                gender = Attribute.findIn(user, "Gender").value

                user_estimates =
                  Nicefitserver.Estimator.Estimate.estimate(gender, height, weight, age)

                variants =
                  Enum.map(product.variants, fn v ->
                    variant_positions =
                      Enum.sort_by(v.positions, fn a ->
                        a.position.name
                      end)

                    variant_positions_tuple =
                      Enum.map(variant_positions, fn p ->
                        selected =
                          Enum.at(
                            Enum.filter(v.positions, fn s ->
                              p.position.name == s.position.name
                            end),
                            0
                          )

                        selected.value
                      end)

                    user_positions_tuple =
                      Enum.map(variant_positions, fn p ->
                        selected =
                          Enum.at(
                            Enum.filter(user_estimates, fn s ->
                              p.position.name == s.position
                            end),
                            0
                          )

                        selected.value
                      end)

                    case Enum.count(variant_positions_tuple) == Enum.count(user_positions_tuple) do
                      true ->
                        %{
                          :variant => v.name,
                          :success => true,
                          :distance =>
                            Distancia.Euclidean.calculate(
                              variant_positions_tuple,
                              user_positions_tuple
                            )
                        }

                      false ->
                        %{:variant => v.name, :success => false, :distance => 99_999}
                    end
                  end)

                variants_sorted =
                  Enum.sort_by(variants, fn e ->
                    e.distance
                  end)

                recommended_variant = Enum.at(variants_sorted, 0)

                case recommended_variant.distance > @max_distance do
                  true ->
                    {:ok, %Recommendation{:recommended_variant => "N/A", :variants => variants}}

                  false ->
                    {:ok,
                     %Recommendation{
                       :recommended_variant => Map.get(recommended_variant, :variant, "N/F"),
                       :variants => variants
                     }}
                end

              _ ->
                {:error}
            end

          _ ->
            {:error}
        end
    end
  end

  def recommend_variant(%{:method => "factual", :user => user, :product => product}) do

    {:ok, %{}}
  end
end
