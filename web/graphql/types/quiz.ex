
defmodule App.Quiz.Type do
  import Ecto.Query

  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.String
  alias GraphQL.Type.List

  alias App.PublicSchema
  alias App.Category.Type

  alias GraphQL.Relay.Connection
  alias GraphQL.Relay.Mutation
  alias GraphQL.Relay.Node

  def connection do
    %{
      name: "Quiz",
      node_type: type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end

  def type do
    %ObjectType{
        name: "Quiz",
        fields: %{
          id: Node.global_id_field("todo"),
          question: %{
          type: %String{},
          resolve: fn(obj, _args, _info) -> obj.question end
        },
          choices: %{
          type: %String{},
          resolve: fn(obj, _args, _info) -> obj.choices end
        },
          author: %{
          type: %String{},
          resolve: fn(obj, _args, _info) -> obj.author end
        },
          categories: %{
          type: App.Category.Type.connection[:connection_type],
          description: "categories the quiz belongs to",
          args: Map.merge(
            %{status: %{type: %String{}, defaultValue: "any"}},
            Connection.args
          ),
          resolve: fn(quiz, args, _ctx) -> 
            query = Ecto.assoc(quiz, :categories)
            query = case args do
                %{status: "active"} -> from things in query, where: things.complete == false
                %{status: "completed"} -> from things in query, where: things.complete == true
                _ -> query
              end
              Connection.Ecto.resolve(Repo, query, args)
            end 
          }, #%{type: CategoryConnection.get},
          mediaUrl: %{
            type: %String{},
            resolve: fn(obj, _args, _info) -> obj.mediaUrl end
          },
          typeCode: %{
            type: %String{},
            resolve: fn(obj, _args, _info) -> obj.typeCode end
          },
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

  defmodule Mutations do
    alias App.User.Type

    
  end
end


