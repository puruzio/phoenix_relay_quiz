defmodule App.Query.User do
  alias GraphQL.Type.List
  import RethinkDB.Query, only: [table: 1]
  alias RethinkDB.Query
  def get do
    %{
      type: %List{ofType: App.User.Type},
      resolve: fn (_, args, _) ->
        table("users")
        |> Query.limit(args.first)
        |> DB.run
        |> DB.handle_graphql_resp
      end
    }
  end

  def get_from_id(id) do
    table("users")
    |> Query.get(id)
    |> DB.run
    |> DB.handle_graphql_resp
  end
end
