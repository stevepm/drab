defmodule DrabTestApp.PageController do
  use DrabTestApp.Web, :controller
  use Drab.Controller 

  def index(conn, _params) do
    render conn, "index.html"
  end
end
