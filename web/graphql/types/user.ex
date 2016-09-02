defmodule App.User.Type do

  @moduledoc """
  Type for the User Object.
  user(id:"sdjflaksdjflkad"){ email id name articles{ edge{ node{ ... } } } }
  """

  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType

  def type do
    %ObjectType{
        name: "User",
        description: "User, a users has friends that are users... ",
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
