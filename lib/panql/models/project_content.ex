defmodule Panql.Models.ProjectContent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_contents" do
    belongs_to :project, Project

    field :language, :string
    field :title, :string
    field :description, :string
    field :introduction, :string
    field :workflow_description, :string
    field :researcher_quote, :string

    timestamps(inserted_at: :created_at)
  end
end
