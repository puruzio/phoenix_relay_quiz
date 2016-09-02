defmodule App.Quiz.Category.Root do
  alias Graphql.Relay.Connection

  def get do
    %{
      name: "Quiz Category",
      type: App.Type.CategoryConnection.get[:connection_type],
      description: "A group that a user is a member of",
      args: Connection.args,
      resolve: { App.Quiz.Category.Root.Resolve, :get}
    }
  end
end

