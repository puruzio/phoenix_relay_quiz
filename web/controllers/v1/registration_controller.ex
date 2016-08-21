defmodule App.V1.RegistrationController do
  use App.Web, :controller

  alias App.User

  import RethinkDB.Query, only: [table_create: 1, table: 2, table: 1, insert: 2]

  plug :scrub_params, "user" when action in [:create]

  ## This is the structure of user json object passed from index.js
#    let user = {
#      username: username,
#      email: email,
#      password: password
#    }

  def create(conn, %{"user" => user_params}) do

    #   changeset = User.registration_changeset(%User{}, user_params)
       user = user_params.user
       table("users") |> insert(%{title: user}) |> App.Database.run

    # case Repo.insert(changeset) do
    #   {:ok, user} ->
    #     broadcast_user = Map.take(user, [:id, :username, :email])
    #     App.Endpoint.broadcast("users:new", "new:user", %{user: broadcast_user})
    #     conn
    #     |> put_status(:created)
    #     |> put_resp_header("location", v1_user_path(conn, :show, user))
    #     |> render(App.V1.UserView, "show.json", user: user)
    #   {:error, changeset} ->
    #     conn
    #     |> put_status(:unprocessable_entity)
    #     |> render(App.ChangesetView, "error.json", changeset: changeset)
    # end
  end
end