defmodule App.Query.Category do
  alias GraphQL.Type.List
  import RethinkDB.Query, only: [table: 1]
  alias RethinkDB.Query
  def get do
    %{
      type: %List{ofType: App.Category.Type},
      resolve: fn (_, args, _) ->
        table("categories")
        |> Query.limit(args.first)
        |> DB.run
        |> DB.handle_graphql_resp
      end
    }
  end

  def get_from_id(id) do
    table("categories")
    |> Query.get(id)
    |> DB.run
    |> DB.handle_graphql_resp
  end
end
