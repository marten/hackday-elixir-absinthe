defmodule Panql.Graphql do
  use Absinthe.Schema

  import_types Panql.Graphql.Types

  query do
    field :projects, list_of(:project) do
      arg :ids, list_of(:integer), default_value: []
      arg :limit, :integer, default_value: 10
      arg :launch_approved, :boolean, default_value: true

      resolve &Panql.Graphql.ProjectResolver.all/2
    end

    # field :workflow, type: :workflow do
    #   arg :id, non_null(:id)
    #   resolve &Panql.Graphql.WorkflowResolver.find/2
    # end
  end
end
