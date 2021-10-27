defmodule NervesCaptivePortalWeb.Router do
  use NervesCaptivePortalWeb, :router

  pipeline :captive_portal_api do
    plug :accepts, ["captive-portal-json"]
  end

  scope "/captive-portal", NervesCaptivePortalWeb do
    pipe_through :captive_portal_api

    get "/api", PageController, :captive_portal_api
  end
end
