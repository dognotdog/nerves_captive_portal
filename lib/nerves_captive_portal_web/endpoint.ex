defmodule NervesCaptivePortalWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :nerves_captive_portal

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug NervesCaptivePortalWeb.Router
end
