defmodule App.GraphQLSession do
  def root_eval(_conn) do
    # %{conn: _conn}
    %{author: "GraphQLSessionOwner"}
  end
end
# https://github.com/graphql-elixir/plug_graphql/issues/22