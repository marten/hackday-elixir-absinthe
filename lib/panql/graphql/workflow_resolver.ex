defmodule Panql.Graphql.WorkflowResolver do
  import Ecto.Query

  alias Panql.Repo
  alias Panql.Models.Workflow

  def all(_args, _info) do
    {:ok, Panql.Repo.all(Workflow)}
  end

  def by_project(project, _args, _info) do
    workflows = Workflow
    |> where([workflow], workflow.project_id == ^project.id)
    |> Repo.all
    {:ok, workflows}
  end

  def find(%{id: id}, _info) do
    case Panql.Repo.get(Workflow, id) do
      nil -> {:error, "Workflow #{id} not found"}
      workflow -> {:ok, workflow}
    end
  end
end
