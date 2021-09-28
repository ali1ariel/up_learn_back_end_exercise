defmodule UpLearnBackEndExercise.Elements.Asset do
  use Ecto.Schema
  import Ecto.Changeset, only: [cast: 3, validate_required: 2]

  schema "assets" do
    field :src, :string
    field :class, :string
    field :alt, :string
    field :size, :string
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:src, :class, :alt, :size])
    |> validate_required([:src])
  end
end
