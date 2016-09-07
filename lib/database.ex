defmodule DB do
  use RethinkDB.Connection

  # database helpers

  def handle_graphql_resp(data) do
    data |> strip_wrapper 
    |> convert_to_symbol_map
      # |> struct_from_map
  end

  defp strip_wrapper(%{data: nil}), do: %{}
  defp strip_wrapper(%{data: doc}), do: doc
  defp strip_wrapper(_anything), do: %{}

  # temp needed for GraphQL resolve function
  defp convert_to_symbol_map(data) when is_list(data) do
    Enum.map(data, fn (doc) ->
      for {key, val} <- doc, into: %{}, do: {String.to_atom(key), val}
    end)
  end
  defp convert_to_symbol_map(doc) when is_map(doc) do
    for {key, val} <- doc, into: %{}, do: {String.to_atom(key), val}
  end

# https://medium.com/@kay.sackey/create-a-struct-from-a-map-within-elixir-78bf592b5d3b#.phfvgmmbn
# App.User.Type line 49 Ecto.assoc/2 requires a struct instead of a map
  # def struct_from_map(a_map) do

  # a_struct = 
  #   case a_map do
  #     %{user: _user} -> %User{}
  #     %{question: _question} -> %Quiz{}
  #     %{category: _category} -> %Category{}
  #   end

  # # Find the keys within the map

  # keys = Map.keys(a_struct) 
  #          |> Enum.filter(fn x -> x != :__struct__ end)
  # # Process map, checking for both string / atom keys
  # processed_map =
  #  for key <- keys, into: %{} do
  #      value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
  #      {key, value}
  #    end
  # a_struct = Map.merge(a_struct, processed_map)
  # a_struct
  # end


end
