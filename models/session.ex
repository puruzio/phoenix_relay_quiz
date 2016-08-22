defmodule App.Session do
  alias App.User

  import RethinkDB.Lambda


  def authenticate(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    #user = repo.get(User, email: String.downcase(params["email"]))

    # query = RethinkDB.Query.table("users") |>
    #   RethinkDB.Query.filter(lambda(fn user ->
    #     user[:email] == "puruzio@gmail.com"
    #   end))

    # [user2 | tail] = repo.query(User, query)
    # IO.inspect user2.email

    case check_password(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end