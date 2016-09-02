defmodule App.Type.UserConnection do
  alias GraphQL.Type.List
  alias GraphQL.Relay.Connection

  def get do
    %{
      name: "User",
      node_type: App.User.Type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end
end
