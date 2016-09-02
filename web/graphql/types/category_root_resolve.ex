defmodule App.Quiz.Category.Root.Resolve do
    alias GraphQL.Relay.Connection

    def get(quiz, args, _ctx) do
        App.Quiz.Category.Root.Query.get(quiz)
            |> Connection.List.resolve(args)
    end
end