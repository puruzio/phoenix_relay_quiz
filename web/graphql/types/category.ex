defmodule App.Category.Type do
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.NonNull
  alias GraphQL.Type.String

  alias GraphQL.Relay.Connection
  alias GraphQL.Relay.Mutation
  alias GraphQL.Relay.Node

  alias App.PublicSchema
  alias App.Quiz.Type

  def connection do
    %{
      name: "Category",
      node_type: type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end

  def type do
    %ObjectType{
        name: "Category",
        fields: %{
          id: Node.global_id_field("todo"),
          # quizReverse: %{type: %List{ofType: App.Type.Quiz.get}},
          # quizReverse: @type_string, #%{type: Quiz.get},
          category: %{
            type: %String{},
            resolve: fn(obj, _args, _info) -> obj.category end},
          categoryType: %{
            type: %String{},
            resolve: fn(obj, _args, _info) -> obj.categoryType end},
          createdAt: %{
            type: %GraphQL.Type.String{},
            resolve: fn( obj, _args, _info) ->
              obj.timestamp
            end
          },
        },
        interfaces: [PublicSchema.node_interface]
      }
  end

end
 