defmodule App.Type.QuizConnection do
  alias GraphQL.Type.List
  alias GraphQL.Relay.Connection

  def get do
    %{
      name: "Quiz",
      node_type: App.Quiz.Type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end
end
