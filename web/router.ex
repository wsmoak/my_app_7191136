defmodule MyApp_7191136.Router do
  use MyApp_7191136.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyApp_7191136 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", MyApp_7191136 do
    pipe_through :browser
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
  end


  # Other scopes may use custom stacks.
  # scope "/api", MyApp_7191136 do
  #   pipe_through :api
  # end
end
