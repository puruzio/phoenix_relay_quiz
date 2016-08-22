defmodule App.V1.RoomView do
  use App.Web, :view

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, App.V1.RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, App.V1.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      roomname: room.roomname,
      email: room.email}
  end
end
