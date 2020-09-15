defmodule ImsWeb.Router do
  use ImsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ImsWeb do
    pipe_through :browser
    get "/", ProductController, :index
  end

  scope "/product", ImsWeb do
    pipe_through :browser
    get "/", ProductController, :index
    get "/:id", ProductController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ImsWeb.Telemetry
    end
  end
end