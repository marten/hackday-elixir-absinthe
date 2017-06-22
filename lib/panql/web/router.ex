defmodule Panql.Web.Router do
  use Panql.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Panql.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug, schema: Panql.Graphql
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Panql.Graphql

end
