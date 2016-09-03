require IEx
defmodule App.GraphQLSession do
  # import Plug.Conn #, only: [put_status: 2]
  use App.Web, :controller
  # alias App.User
  # alias App.V1.SessionController
  # alias Guardian.Plug.EnsureAuthenticated

  # plug EnsureAuthenticated, %{ on_failure: {SessionController, :new }} when not action in [:new, :create]
  

  def root_eval(conn) do
    # %{conn: _conn}
    
    current_user =  Guardian.Plug.current_resource(conn) 
    # IO.inspect conn
    # IEx.pry
    %{author: conn.assigns[:current_user]}
    
    # IO.inspect current_user
    # case current_user do
    #   nil ->
    #     %{author: "No user"}
    #   user ->
    #     %{author: user}    
    # end
    # %{author: current_user}
  end
end
# https://github.com/graphql-elixir/plug_graphql/issues/22