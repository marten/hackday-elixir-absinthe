defmodule Panql.Graphql.Helpers do
  import Ecto.Query
  alias Panql.Repo

  def by_id(model, ids) do
    model
    |> where([m], m.id in ^ids)
    |> Repo.all
    |> Map.new(&{&1, &1})
  end
end
