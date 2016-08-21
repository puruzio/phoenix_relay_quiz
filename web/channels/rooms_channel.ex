defmodule App.RoomsChannel do
  use Phoenix.Channel

  def join("rooms:new", _auth_msg, socket) do
    {:ok, socket}
  end

  def handle_in("new:room", %{"room" => room}, socket) do
    {:noreply, socket}
  end

  def handle_in("remove:room", %{"room_id" => room_id}, socket) do
    broadcast! socket, "remove:room", %{room_id: room_id}
    {:noreply, socket}
  end
end