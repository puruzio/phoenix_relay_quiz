import RethinkDB.Query, only: [table_create: 1, table_drop: 1, table: 1, insert: 2]

defmodule App.PageController do
  use App.Web, :controller

  def reset_db(conn, _params) do
    for table_name <- ["quizs"] do
      table_drop(table_name) |> DB.run
      table_create(table_name) |> DB.run
    end

    insert_quiz(%{ title: "From REST to GraphQL", url: "https://blog.jacobwgillespie.com/from-rest-to-graphql-b4e95e94c26b#.y636o5kd6", timestamp: TimeHelper.currentTime})

    insert_quiz(%{ title: "GraphQL Mutations", url: "https://medium.com/@HurricaneJames/graphql-mutations-fb3ad5ae73c4#.91oewea3o", timestamp: TimeHelper.currentTime})

    insert_quiz(%{ title: "A GraphQL Framework in Non-JS Servers", url: "https://www.youtube.com/watch?v=RNoyPSrQyPs&index=35", timestamp: TimeHelper.currentTime})

    insert_quiz(%{ title: "GraphQL: A legit reason to use it.", url: "https://edgecoders.com/graphql-a-legit-reason-to-use-it-7858ce31638a#.7nl8a49oc", timestamp: TimeHelper.currentTime})

    insert_quiz(%{ title: "Initial Impressions on GraphQL & Relay", url: "https://kadira.io/blog/graphql/initial-impression-on-relay-and-graphql", timestamp: TimeHelper.currentTime})

    text conn, "Database Reset"
  end


  def index(conn, _params) do
    render conn, "index.html"
  end


  defp insert_quiz(doc), do: table("quizs") |> insert(doc) |> DB.run
end
