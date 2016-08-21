defmodule App.GraphQLSession do
  def root_eval(_conn) do
    %{conn: _conn}
  end
end
# https://github.com/graphql-elixir/plug_graphql/issues/22