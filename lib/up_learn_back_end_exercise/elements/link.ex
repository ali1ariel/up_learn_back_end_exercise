defmodule UpLearnBackEndExercise.Elements.Link do
  use Ecto.Schema
  import Ecto.Changeset, only: [cast: 3, validate_required: 2]

  schema "links" do
    field :href, :string
    field :class, :string
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :class])
    |> validate_required([:href])
  end
end
