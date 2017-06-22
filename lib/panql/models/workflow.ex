defmodule Panql.Models.Workflow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workflows" do
    belongs_to :project, Panql.Models.Project

    field :display_name, :string

    timestamps(inserted_at: :created_at)
  end
end
