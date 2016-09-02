defmodule App.Type.CategoryConnection do
  alias GraphQL.Type.List
  alias GraphQL.Relay.Connection

  def get do
    %{
      name: "Category",
      node_type: App.Category.Type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end
end
