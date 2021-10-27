defmodule NervesCaptivePortalWeb.Router do
  use NervesCaptivePortalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :captive_portal_api do
    plug :accepts, ["captive-portal-json"]
  end

  scope "/", NervesCaptivePortalWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/captive-portal", NervesCaptivePortalWeb do
    pipe_through :captive_portal_api

    get "/api", PageController, :captive_portal_api
  end


  # Other scopes may use custom stacks.
  # scope "/api", NervesCaptivePortalWeb do
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
      live_dashboard "/dashboard", metrics: NervesCaptivePortalWeb.Telemetry
    end
  end
end
