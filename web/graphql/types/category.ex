defmodule App.Category.Type do
  @type_string %{type: %GraphQL.Type.String{}}
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.NonNull

  def type do
    %ObjectType{
        name: "Category",
        fields: %{
          id: @type_string,
          # quizReverse: %{type: %List{ofType: App.Type.Quiz.get}},
          quizReverse: @type_string, #%{type: Quiz.get},
          category: @type_string,
          categoryType: @type_string,
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
