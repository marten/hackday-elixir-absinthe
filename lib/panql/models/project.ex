defmodule Panql.Models.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    has_many :workflows, Panql.Models.Workflow
    has_many :contents, Panql.Models.ProjectContent

    field :name, :string
    field :display_name, :string
    field :slug, :string
    field :configuration, :map

    field :user_count, :integer
    field :classifications_count, :integer

    field :state, :integer
    field :launch_approved, :boolean

    timestamps(inserted_at: :created_at)
  end
end
