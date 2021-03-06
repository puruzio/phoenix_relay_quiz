defmodule App.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias App.Repo
  alias App.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  #def from_token("User:" <> id), do: { :ok, Repo.get(User, String.to_integer(id)) }
  def from_token("User:" <> id), do: { :ok, Repo.get(User, id) }
  #def from_token("User:" <> id), do
  #  IEx.pry
  #  IO.inspect id
  #  { :ok, Repo.all(User) }
  #  end
  def from_token(_), do: { :error, "Unknown resource type" }
end