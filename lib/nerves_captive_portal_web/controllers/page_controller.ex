defmodule NervesCaptivePortalWeb.PageController do
  use NervesCaptivePortalWeb, :controller

  def captive_portal_api(conn, _params) do
    portal_url = Application.get_env(:nerves_captive_portal, :portal_url, "http://captive.portal/")
    conn
    |> put_resp_content_type("application/captive+json")
    |> json(%{
      captive: true,
      "user-portal-url": portal_url,
    })
  end

end
