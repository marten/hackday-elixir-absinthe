defmodule Panql.Graphql.ProjectResolver do
  import Ecto.Query
  alias Panql.Repo
  alias Panql.Models.{Project, ProjectContent}

  def all(%{ids: ids, limit: limit, launch_approved: launch_approved}, _info) do
    projects = Project
    |> by_ids(ids)
    |> where(launch_approved: ^launch_approved)
    |> limit(^limit)
    |> Repo.all
    {:ok, projects}
  end

  def contents_for_project(project, %{language: language}, _info) do
    content = ProjectContent
    |> where(project_id: ^project.id, language: ^to_string(language))
    |> Repo.one

    {:ok, content}
  end

  def contents_for_projects(%{language: language}, ids) do
    content = ProjectContent
    |> where([c], c.project_id in ^ids)
    |> where(language: ^to_string(language))
    |> Repo.all
    |> Map.new(&{&1.project_id, &1})
  end

  defp by_ids(query, ids) do
    case ids do
      [] -> query
      _ -> where(query, [project], project.id in ^ids)
    end
  end
end
