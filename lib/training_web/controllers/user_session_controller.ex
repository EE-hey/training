defmodule TrainingWeb.UserSessionController do
  use TrainingWeb, :controller

  alias Training.Accounts
  alias TrainingWeb.UserAuth

  def new(conn, _params) do
    prout = get_session(conn, "prout")
    IO.inspect(prout)
    conn
    |> put_session("prout", "prout-test-du-cul")
    |> render("new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params
    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
