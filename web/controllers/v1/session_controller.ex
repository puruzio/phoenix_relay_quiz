defmodule App.V1.SessionController do
  use App.Web, :controller

  def create(conn, %{"session" => session_params}) do
    case App.Session.authenticate(session_params, App.Repo) do
      # If the user is authenticated, send back a new JWT
      {:ok, user} ->
        conn = Guardian.Plug.api_sign_in(conn, user, :token)

        conn
        |> put_status(:created)
        |> assign(:current_user, user) #https://github.com/graphql-elixir/graphql/wiki/How-to-do-authentication-and-authorization-in-a-Phoenix-application-with-GraphQL
        |> render(App.V1.SessionView, "show.json", jwt: Guardian.Plug.current_token(conn))
      :error ->
        conn
        |> put_status(:unprocessable_entity)
    end
  end

  def unauthenticated_api(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(App.V1.SessionView, "error.json", error: "Not Authenticated")
  end
end
