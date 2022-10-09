# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Nicefitserver.Repo.insert!(%Nicefitserver.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Nicefitserver.Repository.Entities
alias Nicefitserver.Repo

product =
  Repo.insert!(%Entities.Product{
    name: "Vestido largo M. Christian Lacroix",
    reference: "22WWVF039019",
    status: 0
  })

cardinalities = Ecto.Enum.values(Entities.ProductTags, :cardinality)

IO.inspect(cardinalities)

Repo.insert!(%Entities.ProductTags{
  product_id: product.id,
  name: "composition",
  cardinality: :factual,
  value: "63% ACRILIC, 27% POLIESTER, 10% POLIAMIDA"
})

variant_xs =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "XS"
  })

variant_s =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "S"
  })

variant_m =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "M"
  })

variant_l =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "L"
  })

variant_xl =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "XL"
  })

variant_xl =
  Repo.insert!(%Entities.ProductVariant{
    product_id: product.id,
    name: "XXL"
  })

attribute_brand = Repo.insert!(%Entities.Attribute{name: "Brand"})
attribute_gender = Repo.insert!(%Entities.Attribute{name: "Gender"})
attribute_age = Repo.insert!(%Entities.Attribute{name: "Age"})
attribute_fit = Repo.insert!(%Entities.Attribute{name: "Fit"})

Repo.insert!(%Entities.ProductAttribute{
  product_id: product.id,
  attribute_id: attribute_brand.id,
  value: "Desigual",
  cardinality: :factual
})

Repo.insert!(%Entities.ProductAttribute{
  product_id: product.id,
  attribute_id: attribute_gender.id,
  value: "Female",
  cardinality: :factual
})

chest =
  Repo.insert!(%Entities.Position{
    name: "Chest",
    dimensions: 3
  })

hips =
  Repo.insert!(%Entities.Position{
    name: "Hips",
    dimensions: 3
  })

height =
  Repo.insert!(%Entities.Position{
    name: "Height",
    dimensions: 1
  })

weight =
  Repo.insert!(%Entities.Position{
    name: "Weight",
    dimensions: 1
  })

age =
  Repo.insert!(%Entities.Position{
    name: "Age",
    dimensions: 1
  })

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: chest.id,
  product_variant_id: variant_xs.id,
  value: 800,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: chest.id,
  product_variant_id: variant_s.id,
  value: 850,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: chest.id,
  product_variant_id: variant_m.id,
  value: 900,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: chest.id,
  product_variant_id: variant_l.id,
  value: 950,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: chest.id,
  product_variant_id: variant_xl.id,
  value: 1000,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: hips.id,
  product_variant_id: variant_xs.id,
  value: 780,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: hips.id,
  product_variant_id: variant_s.id,
  value: 830,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: hips.id,
  product_variant_id: variant_m.id,
  value: 880,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: hips.id,
  product_variant_id: variant_l.id,
  value: 930,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantPosition{
  position_id: hips.id,
  product_variant_id: variant_xl.id,
  value: 980,
  cardinality: :factual
})

Repo.insert!(%Entities.ProductVariantAttribute{
  product_variant_id: variant_xl.id,
  attribute_id: attribute_fit.id,
  value: "slim",
  cardinality: :factual
})

ansur2_sources = [
    %{
      file: "datasets/ANSUR2/men.csv",
     gender: "male"
    },
    %{
      file: "datasets/ANSUR2/women.csv",
      gender: "female"
    },
]

Enum.map(ansur2_sources, fn source ->
  File.stream!(Path.expand(source.file))
  |> CSV.decode(separator: ?,, headers: true)
  |> Enum.map(fn k ->
    case k do
      {:ok, e} ->
        IO.puts("Inserting " <> e["subjectid"] <> " as factual subject")
        ansur_user = Repo.insert!(%Entities.User{})

        Repo.insert!(%Entities.UserAttribute{
          user_id: ansur_user.id,
          attribute_id: attribute_gender.id,
          value: source.gender,
          cardinality: :factual
        })

        Repo.insert!(%Entities.UserAttribute{
          user_id: ansur_user.id,
          attribute_id: attribute_age.id,
          value: e["Age"],
          cardinality: :factual
        })

        Repo.insert!(%Entities.UserPosition{
          user_id: ansur_user.id,
          position_id: height.id,
          value: String.to_integer(e["stature"]),
          cardinality: :factual
        })

        Repo.insert!(%Entities.UserPosition{
          user_id: ansur_user.id,
          position_id: weight.id,
          value: round(String.to_integer(e["weightkg"]) / 10),
          cardinality: :factual
        })

        Repo.insert!(%Entities.UserPosition{
          user_id: ansur_user.id,
          position_id: chest.id,
          value: String.to_integer(e["chestcircumference"]),
          cardinality: :factual
        })

        Repo.insert!(%Entities.UserPosition{
          user_id: ansur_user.id,
          position_id: hips.id,
          value: String.to_integer(e["buttockcircumference"]),
          cardinality: :factual
        })
    end
  end)
end)

defmodule Getter do
  def getName(v) when is_integer(v) do
    Integer.to_string(v)
  end

  def getName(v) do
    v
  end
end

{:ok, body} = File.read("datasets/victoria_beckham.products.json")
{:ok, products} = Poison.decode(body)

products["products"]
|> Enum.filter(fn p -> p["product_type"] == "Ready-to-wear" end)
|> Enum.map(fn p ->
  product =
    Repo.insert!(%Entities.Product{
      reference: Integer.to_string(p["id"]),
      name: p["title"],
      status: 1
    })

  Enum.map(p["variants"], fn v ->
    Repo.insert!(%Entities.ProductVariant{
      product_id: product.id,
      name: Getter.getName(v["title"])
    })
  end)

  Repo.insert!(%Entities.ProductAttribute{
    product_id: product.id,
    attribute_id: attribute_gender.id,
    value: "Female",
    cardinality: :factual
  })
end)
