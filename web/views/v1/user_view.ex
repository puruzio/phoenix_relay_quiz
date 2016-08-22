defmodule App.V1.UserView do
  use App.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, App.V1.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, App.V1.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email}
  end
end
