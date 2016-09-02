
defmodule App.Quiz.Type do
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType
  alias App.Type.CategoryConnection
  alias GraphQL.Type.List
  alias App.PublicSchema
  alias GraphQL.Relay.Node
  alias App.Category.Type

  def type do
    %ObjectType{
        name: "Quiz",
        fields: %{
          id: @type_string,
          question: @type_string,
          choices: @type_string,
          author: @type_string,
          categories: App.Quiz.Category.Root.get, #%{type: CategoryConnection.get},
          mediaUrl: @type_string,
          typeCode: @type_string,
          createdAt: %{
            type: %GraphQL.Type.String{},
            resolve: fn( obj, _args, _info) ->
              obj.timestamp
            end
          }
        },
      interfaces: [PublicSchema.node_interface]
      }
  end

end


