defmodule App.Router do
  use App.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource

    # plug GraphQL.Plug.Endpoint, [schema: {App.PublicSchema, :schema}, root_value: &App.GraphQLSession.root_eval/1]
  end

  scope "/graphql" do
    pipe_through :api
    forward "/", GraphQL.Plug, [schema: {App.PublicSchema, :schema}, root_value: {App.GraphQLSession, :root_eval} ]
  end

  scope "/", App do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/reset", PageController, :reset_db
    
  end

  # Other scopes may use custom stacks.
  scope "/api", App do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/users", UserController, except: [:new, :edit]
      # resources "/rooms", RoomController, except: [:new, :edit]
      post "/register", RegistrationController, :create
      # post "/rmregister", RmRegistrationController, :create
      get "/current_user", UserController, :current_user
      post "/login", SessionController, :create
    end
  end
end
