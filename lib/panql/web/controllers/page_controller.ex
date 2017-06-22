defmodule Panql.Web.PageController do
  use Panql.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
