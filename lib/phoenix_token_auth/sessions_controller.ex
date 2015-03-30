defmodule PhoenixTokenAuth.SessionsController do
  use Phoenix.Controller
  alias PhoenixTokenAuth.Util
  alias PhoenixTokenAuth.Authenticator

  plug :action


  @doc """
Log in as an existing user.

Parameter are "email" and "password".

Responds with status 200 and {token: token} if credentials were correct.
Responds with status 401 and {errors: error_message} otherwise.
"""
  def create(conn, %{"email" => email, "password" => password}) do
    case Authenticator.authenticate(email, password) do
      {:ok, token} -> json conn, %{token: token}
      {:error, errors} -> Util.send_error(conn, errors, 401)
    end
  end
end
