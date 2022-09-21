defmodule TrainingWeb.PageController do
  use TrainingWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_cookie("cul_bite_cul", "poil de merde du cul")
    |> put_resp_cookie("fuck_macron", "gros connard de merde")
    |> redirect(to: "/training")
  end
  def training(conn, _params) do
    conn
    |> render("training.html")
  end
  def new_room(conn, _params) do
    render(conn, "new_room.html")
  end
end
