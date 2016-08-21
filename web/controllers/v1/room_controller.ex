

# defmodule App.V1.RoomController do

#   use App.Web, :controller

#   alias App.Room


#   #import RethinkDB.Query, only: [table_create: 1, table: 2, table: 1, insert: 2]

#   #def init(conn, _params) do
#   #  table_create("users")
#   #  |> App.Database.run

#   #  table("users") |> insert(%{title: "Python"}) |> Example.Database.run
#   #  table("users") |> insert(%{title: "Elixir"}) |> Example.Database.run

#   #  text conn, "Posts table created. Visit '/' to fetch posts"
#   #end

#   # Simple authentication provided by Guardian
#   # This code will check every incoming HTTP request for a JWT in the
#   # 'Authorization' header
#   plug Guardian.Plug.EnsureAuthenticated, on_failure: { App.V1.SessionController, :unauthenticated_api }

#   plug :scrub_params, "room" when action in [:create, :update]

#   def index(conn, _params) do
#   #https://medium.com/@diamondgfx/debugging-phoenix-with-iex-pry-5417256e1d11#.ygp2iass6

#     rooms = Repo.all(Room)

#     IO.inspect rooms

#     render(conn, "index.json", rooms: rooms)
#   end

#   def create(conn, %{"room" => room_params}) do

#     changeset = Room.registration_changeset(%Room{}, room_params)

#     case Repo.insert(changeset) do
#       {:ok, room} ->
#         conn
#         |> put_status(:created)
#         |> put_resp_header("location", v1_room_path(conn, :show, room))
#         |> render("show.json", room: room)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(App.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     room = Repo.get(Room, id)
#     render(conn, "show.json", room: room)
#   end

#   def update(conn, %{"id" => id, "room" => room_params}) do
#     room = Repo.get(Room, id)
#     changeset = Room.changeset(room, room_params)

#     case Repo.update(changeset) do
#       {:ok, room} ->
#         render(conn, "show.json", room: room)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(App.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     room = Repo.get(Room, id)
    
#     ## Here we use delete! (with a bang) because we expect
#     ## it to always work (and if it does not, it will raise).
#     Repo.delete(room)

#     send_resp(conn, :no_content, "")
#   end

#   def current_room(conn, %{"jwt" => jwt}) do
#     case Guardian.Plug.current_resource(conn) do
#       nil ->
#         conn
#         |> put_status(:not_found)
#         |> render(App.V1.SessionView, "error.json", error: "Room not found")
#       room ->
#         conn
#         |> put_status(:ok)
#         |> render("show.json", room: room)
#     end
#   end
# end
