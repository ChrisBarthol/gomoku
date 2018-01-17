defmodule Gomoku.PageController do
  use Gomoku.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
