# defmodule App.V1.RmRegistrationController do
#   use App.Web, :controller

#   alias App.Room

#   plug :scrub_params, "room" when action in [:create]

#   ## This is the structure of room json object passed from index.js
#   #  let room = {
#   #    roomname: roomname,
#   #    email: email,
#   #    password: password
#   #  }

#   def create(conn, %{"room" => room_params}) do

#       changeset = Room.registration_changeset(%Room{}, room_params)

#     case Repo.insert(changeset) do
#       {:ok, room} ->
#         broadcast_room = Map.take(room, [:id, :roomname, :email])
#         App.Endpoint.broadcast("room:new", "new:room", %{room: broadcast_room})
#         conn
#         |> put_status(:created)
#         |> put_resp_header("location", v1_room_path(conn, :show, room))
#         |> render(App.V1.RoomView, "show.json", room: room)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(App.ChangesetView, "error.json", changeset: changeset)
#     end
#   end
# end