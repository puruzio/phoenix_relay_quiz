defmodule App.Type.User do
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType

  def get do
    %ObjectType{
        name: "User",
        fields: %{
          id: @type_string,
          username: @type_string,
          email: @type_string,
          createdAt: %{
            type: %GraphQL.Type.String{},
            resolve: fn( obj, _args, _info) ->
              obj.timestamp
            end
          }
        }
      }
  end

end
