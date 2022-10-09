defmodule Nicefitserver.Recommender.Recommendation do

  alias __MODULE__

  @type t :: %Recommendation{
    recommended_variant: String.t(),
    variants: tuple()
  }

  @derive Jason.Encoder
  defstruct [
  :recommended_variant,
  :variants
  ]
end
