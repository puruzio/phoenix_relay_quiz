defmodule App.Plugs.Authenticate do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    # Make sure you've already `put_session(conn, :user_id, user.id)` somewhere
    # else in your app. We assume your app already handles setting the user
    # session.
    user_id = get_session(conn, :user_id)
    if user_id do
      user = YourApp.Repo.get!(YourApp.User, user_id)
      assign(conn, :current_user, user)
    else
      # TODO: Add support for returning a JSON error for JSON requests
      conn
        |> put_flash(:error, 'You need to be signed in to view this page.')
        |> redirect(to: "/")
    end
  end
end