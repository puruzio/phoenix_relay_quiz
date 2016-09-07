
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

  import RethinkDB.Query#, only: [table: 1]
  alias RethinkDB.Query

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
            # args: Map.merge(
            #   %{status: %{type: %String{}, defaultValue: "any"}},
            #   Connection.args
            # ),
            args: Map.merge(Connection.args, %{query: @type_string}),
            resolve: fn(quiz, args, _ctx) -> 
              table("quizs")
              # |> Query.get_all("id", table("categories"), %{index: "quiz_id"})
              # |> Query.concat_map()
              # |> map(fn( x , y) -> y end)
              |> outer_join(
                table("categories"), &(eq(&1["id"], &2["quiz_id"]))
                )
              |> Query.map(fn( x) -> x.right end)
              
              # |> Query.limit(args.first)
              |> DB.run
              |> DB.handle_graphql_resp
              # query = Ecto.assoc(quiz, :categories)
              # query = case args do
              #     %{status: "active"} -> from things in query, where: things.complete == false
              #     %{status: "completed"} -> from things in query, where: things.complete == true
              #     _ -> query
              #   end
              #   Connection.Ecto.resolve(Repo, query, args)
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

  def find(id) do
    Repo.get!(App.Quiz, id)
  end

  defmodule Mutations do
    alias App.User.Type

    
  end
end


