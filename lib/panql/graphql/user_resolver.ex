defmodule Panql.Graphql.UserResolver do
  def all(_args, _info) do
    {:ok, Panql.Repo.all(Panql.Models.User)}
  end
end
