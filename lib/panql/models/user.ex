defmodule Panql.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :display_name, :string

    timestamps(inserted_at: :created_at)
  end
end
