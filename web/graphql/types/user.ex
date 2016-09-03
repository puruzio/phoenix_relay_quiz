defmodule App.User.Type do

  @moduledoc """
  Type for the User Object.
  user(id:"sdjflaksdjflkad"){ email id name articles{ edge{ node{ ... } } } }
  """

  @type_string %{type: %GraphQL.Type.String{}}
  import Ecto.Query

  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.String
  alias GraphQL.Type.Int

  alias GraphQL.Relay.Connection
  alias GraphQL.Relay.Mutation
  alias GraphQL.Relay.Node

  alias App.PublicSchema


  def connection do
    %{
      name: "User",
      node_type: type,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end

  def type do
    %ObjectType{
        name: "User",
        description: "User, a users has friends that are users... ",
        fields: %{
          id: Node.global_id_field("user"),
          username: @type_string,
          email: @type_string,
          quizs: %{
            type: App.Quiz.Type.connection[:connection_type],
            description: "quiz authored by user",
            args: Map.merge(
              %{status: %{type: %String{}, defaultValue: "any"}},
              Connection.args
            ),
            resolve: fn(user, args, _ctx) ->
              query = Ecto.assoc(user, :quizs)
              query = case args do
                %{status: "active"} -> from things in query, where: things.complete == false
                %{status: "completed"} -> from things in query, where: things.complete == true
                _ -> query
              end
              Connection.Ecto.resolve(Repo, query, args)
            end
          },
          totalCount: %{
            type: %Int{},
            resolve: fn(user, _args, _info) ->
              query = Ecto.assoc(user, :quizs)
              completed_query = from things in query, where: things.complete == true
              completed_count_query = from things in completed_query, select: count(things.id)
              Repo.one(completed_count_query)
            end

          },
          inserted_at: %{
            type: %GraphQL.Type.String{},
            resolve: fn( obj, _args, _info) ->
              obj.inserted_at
            end
          }
        },
        interfaces: [PublicSchema.node_interface]
      }
  end

  def find(id) do
    App.User
      |> preload(:quizs)
      |> Repo.get(id)
  end

  defmodule Mutations do
    
  end
end


# defmodule App.Quiz.User.Root do
#   alias Graphql.Relay.Connection

#   def get do
#     %{
#       name: "Quiz Category",
#       type: App.User.Connection.get[:connection_type],
#       description: "A group that a user is a member of",
#       args: Connection.args,
#       resolve: { App.Quiz.User.Root.Resolve, :get}
#     }
#   end
# end

# defmodule App.Quiz.User.Root.Resolve do
#     alias GraphQL.Relay.Connection

#     def get(user, args, _ctx) do
#         App.Quiz.User.Root.Query.get(user)
#             |> Connection.List.resolve(args)
#     end
# end