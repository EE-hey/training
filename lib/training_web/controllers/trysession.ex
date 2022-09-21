defmodule TrainingWeb.Trysession do

  use TrainingWeb, :controller

  def index(conn, _params) do
    prout = get_session(conn, "prout")
    inspect prout
    render(conn,"trysession.html")
  end
end
