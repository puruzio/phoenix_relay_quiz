# import RethinkDB.Query, only: [table_create: 1, table_drop: 1, table: 1, insert: 2]

defmodule App.PageController do
  use App.Web, :controller
  alias App.User
  alias App.Repo

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

  def init(conn, _params) do
    Repo.

    insert_categories(%{ quiz_id: "456adb5b-28f1-4b37-9226-9a179b0c48cc", category: "math", timestamp: TimeHelper.currentTime, categoryType: "general"})
    insert_categories(%{ quiz_id: "5125f932-19a2-4051-8612-5dee699e9421", category: "phoenixframework", timestamp: TimeHelper.currentTime, categoryType: "programming"})
    insert_categories(%{ quiz_id: "2df66b26-4e46-4191-ab0a-3ecf95812b0b", category: "elixir", timestamp: TimeHelper.currentTime, categoryType: "programming"})
    insert_categories(%{ quiz_id: "2df66b26-4e46-4191-ab0a-3ecf95812b0b", category: "history", timestamp: TimeHelper.currentTime, categoryType: "general"})
    insert_categories(%{ quiz_id: "456adb5b-28f1-4b37-9226-9a179b0c48cc", category: "people", timestamp: TimeHelper.currentTime, categoryType: "general"})
    insert_categories(%{ quiz_id: "456adb5b-28f1-4b37-9226-9a179b0c48cc", category: "rethinkdb", timestamp: TimeHelper.currentTime, categoryType: "programming"})

  for table_name <- ["quizs"] do
      table_create(table_name) |> DB.run
    end

    insert_quiz(%{ author: "dXNlcjozYjUxMDlhMy1kNzdhLTQ0M2QtODUzYi1kM2E3MTc1ZjA2NDQ=", question: "Which of these make a number infinite when divided by it?", timestamp: TimeHelper.currentTime, choices: "234,322, -344, 0", typeCode: "1000", mediaUrl: "http://www.clipartpanda.com/clipart_images/math-clip-art-3917712"})
    insert_quiz(%{ author: "dXNlcjozYjUxMDlhMy1kNzdhLTQ0M2QtODUzYi1kM2E3MTc1ZjA2NDQ=", question: "Which language is the Phoenixframework written in?", timestamp: TimeHelper.currentTime, choices: "elixir, go-lang, elm-lang, python", typeCode: "1000", mediaUrl: "http://animal-dream.com/data_images/phoenix/phoenix2.html"})
    insert_quiz(%{ author: "dXNlcjoxNWU2ZjQwNC03ODk2LTQ1MDEtOTBmMC1kNjE5YjZmYWQ3ZTY=", question: "Who is the creator of Elixir-lang?", timestamp: TimeHelper.currentTime, choices: "Jose Valim, Dave Thomas, Chris McCord, Lee Byron", typeCode: "1000", mediaUrl: "https://en.wikipedia.org/wiki/File:Elixir_programming_language_logo.png"})
    insert_quiz(%{ author: "dXNlcjoxNWU2ZjQwNC03ODk2LTQ1MDEtOTBmMC1kNjE5YjZmYWQ3ZTY=", question: "In December 1941, Japan attacked _____ and European territories in the Pacific Ocean", timestamp: TimeHelper.currentTime, choices: "India, USA, Australia, England", typeCode: "1000",  mediaUrl: "https://lh6.ggpht.com/LKQC9SJVK6Ia1l-x-N52_veQaqBoSjgXf3czvyc7STU63Ws264qFZDukPnT9r7qXjA=w300-rw"})
    insert_quiz(%{ author: "dXNlcjoxMDExOTQ4NS04NDAwLTQyYzctYmI0Ni0yMGIxZDQxZjI4NzU=", question: "____ is an American former competitive swimmer and the most decorated Olympian of all time, with a total of 28 medals.", timestamp: TimeHelper.currentTime, choices: "Michael Phelps, James Dean, Nicolas Cage, Michael Fox, Jimmy Carter", typeCode: "1000", mediaUrl: "https://upload.wikimedia.org/wikipedia/en/e/e4/Steve_Jobs_by_Walter_Isaacson.jpg"})
    insert_quiz(%{ author: "dXNlcjoxMDExOTQ4NS04NDAwLTQyYzctYmI0Ni0yMGIxZDQxZjI4NzU=", question: "What is the closest to Rethinkdb", timestamp: TimeHelper.currentTime, choices: "NoSQL, Postgres, DB2, MSSQL", typeCode: "1000", mediaUrl: "https://pbs.twimg.com/profile_images/665827690637713408/EVEOTX3f.png"})

    text conn, "Table categories created"
  end

  defp insert_quiz(doc), do: table("quizs") |> insert(doc) |> DB.run
  defp insert_categories(doc), do: table("categories") |> insert(doc) |> DB.run
end
