
defmodule App.Type.Quiz do
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType

  def get do
    %ObjectType{
        name: "Quiz",
        fields: %{
          id: @type_string,
          question: @type_string,
          choices: @type_string,
          author: @type_string,
          categories: @type_string,
          mediaUrl: @type_string,
          typeCode: @type_string,
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
