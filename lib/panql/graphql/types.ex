defmodule Panql.Graphql.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Panql.Repo

  @desc "Anything that is serializable to JSON can fit in this. Don't complain if the data inside this is not documented."
  scalar :here_be_dragons do
    # parse &Poison.decode!(&1.value)
    # serialize &Poison.encode!(&1)

    parse fn x -> x end
    serialize fn x -> x end
  end

  enum :language do
    value :en
    value :nl
    value :es
  end

  @desc "A Project is a collection of subjects and task workflows that a volunteer performs on subjects. The project also holds supplementary text describing the tasks volunteers perform."
  object :project do
    field :id, :id
    field :slug, :string
    field :display_name, :string, description: "The preferred display string for this project"
    field :workflows, list_of(:workflow), resolve: assoc(:workflows)
    field :content, :project_content do
      arg :language, non_null(:language)
      resolve fn project, args, _ ->
        batch({Panql.Graphql.ProjectResolver, :contents_for_projects, args}, project.id, fn results ->
          {:ok, Map.get(results, project.id)}
        end)
      end
    end

    field :configuration, :here_be_dragons
  end

  @desc "ProjectContent resources contains all strings for a project for a particular language. This resource will normally only be accessed by project translators. Users will receive translated versions of projects based on their Accept-Language header or preferences."
  object :project_content do
    field :id
    field :language, :language
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :introduction, :string
    field :workflow_description, :string
    field :researcher_quote, :string
  end

  @desc "Workflows represent the series of questions/tasks a user will be asked to complete for a subject. Subjects are selected from SubjectSets. A Workflow may have many SubjectSets linked to, but a SubjectSet may only be linked to a single Workflow."
  object :workflow do
    field :id, :id
    field :display_name, :string

    field :tasks, :here_be_dragons, description: "Who knows what dangers lurk inside this field. Proceed at your own peril."
  end
end
