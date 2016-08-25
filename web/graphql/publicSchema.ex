defmodule App.PublicSchema do

  import List , only: [first: 1]
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.List
  alias GraphQL.Type.NonNull
  alias GraphQL.Type.String
  alias GraphQL.Relay.Mutation
  alias RethinkDB.Query
  alias GraphQL.Relay.Connection
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Relay.Node

  @store %{
    id: 1
  }

  def node_interface do
    Node.define_interface(fn(obj) ->
      IO.puts "node_interface"
      IO.inspect obj
      case obj do
        @store ->
          App.Type.Store.get
        _ ->
          %{}
      end
    end)
  end

  def node_field do
    Node.define_field(node_interface, fn (_item, args, _ctx) ->
      [type, id] = Node.from_global_id(args[:id])
      case type do
        "Store" ->
          @store
        _ ->
          %{}
      end
    end)
  end

  def schema do
    %Schema{
      query: %ObjectType{
        name: "Query",
        fields: %{
          node: node_field,
          store: %{
            type: App.Type.Store.get,
            resolve: fn (doc, _args, _) ->
              @store
            end
          }
        }
      },
      mutation: %ObjectType{
        name: "Mutation",
        fields: %{
          createQuiz: Mutation.new(%{
            name: "CreateQuiz",
            input_fields: %{
              question: %{type: %NonNull{ofType: %String{}}},
              choices: %{type: %NonNull{ofType: %String{}}},
              author: %{type: %NonNull{ofType: %String{}}},
            },
            output_fields: %{
              quizEdge: %{
                type: App.Type.QuizConnection.get[:edge_type],
                resolve: fn (obj, _args, _info) ->
                  %{
                    node: App.Query.Quiz.get_from_id(first(obj[:generated_keys])),
                    cursor: first(obj[:generated_keys])
                  }
                end
              },
              store: %{
                type: App.Type.Store.get,
                resolve: fn (obj, _args, _info) ->
                  @store
                end
              }
            },
            mutate_and_get_payload: fn(input, _info) ->
              Query.table("quizs")
                |> Query.insert(
                  %{
                    question: input["question"],
                    choices: input["choices"],
                    author: _info.root_value.author,
                    timestamp: TimeHelper.currentTime
                    })
                |> DB.run
                |> DB.handle_graphql_resp
            end
          }),
          createUser: Mutation.new(%{
            name: "CreateUser",
            input_fields: %{
              id: %{type: %NonNull{ofType: %String{}}},
              username: %{type: %NonNull{ofType: %String{}}},
              email: %{type: %NonNull{ofType: %String{}}},
            },
            output_fields: %{
              userEdge: %{
                type: App.Type.UserConnection.get[:edge_type],
                resolve: fn (obj, _args, _info) ->
                  %{
                    node: App.Query.User.get_from_id(first(obj[:generated_keys])),
                    cursor: first(obj[:generated_keys])
                  }
                end
              },
              store: %{
                type: App.Type.Store.get,
                resolve: fn (obj, _args, _info) ->
                  @store
                end
              }
            },
            mutate_and_get_payload: fn(input, _info) ->
              Query.table("users")
                |> Query.insert(
                  %{
                    username: input["username"],
                    email: input["email"],
                    timestamp: TimeHelper.currentTime
                    })
                |> DB.run
                |> DB.handle_graphql_resp
            end
          })
        }
      }
    }
  end
end
