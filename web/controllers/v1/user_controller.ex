defmodule App.V1.UserController do

  use App.Web, :controller

  alias App.User


  import RethinkDB.Query, only: [table_create: 1, table: 2, table: 1, insert: 2]

#   def init(conn, _params) do
#    table_create("users")
#    |> App.Database.run

#    table("users") |> insert(%{title: "Python"}) |> Example.Database.run
#    table("users") |> insert(%{title: "Elixir"}) |> Example.Database.run

#    text conn, "Posts table created. Visit '/' to fetch posts"
#   end

  # Simple authentication provided by Guardian
  # This code will check every incoming HTTP request for a JWT in the
  # 'Authorization' header
  plug Guardian.Plug.EnsureAuthenticated, on_failure: { App.V1.SessionController, :unauthenticated_api }

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
  #https://medium.com/@diamondgfx/debugging-phoenix-with-iex-pry-5417256e1d11#.ygp2iass6

    users = Repo.all(User)

    # IO.inspect users
    # users = table("users")
    # |> App.Database.run
    # |> IO.inspect
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
#       def init(conn, _params) do
#        table_create("users")
#        |> App.Database.run

#        table("users") |> insert(%{title: "Python"}) |> App.Database.run
#        table("users") |> insert(%{title: "Elixir"}) |> App.Database.run

#        text conn, "Posts table created. Visit '/' to fetch posts"
#      end

    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(App.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(App.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)

    ## Here we use delete! (with a bang) because we expect
    ## it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

  def current_user(conn, %{"jwt" => jwt}) do
    # IO.inspect "current_user module"
    # IO.inspect conn
    # IO.inspect jwt

    case Guardian.Plug.current_resource(conn) do

      nil -> 
        conn
        |> put_status(:not_found)
        |> render(App.V1.SessionView, "error.json", error: "User not found")
      user ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)
    end
  end
end
