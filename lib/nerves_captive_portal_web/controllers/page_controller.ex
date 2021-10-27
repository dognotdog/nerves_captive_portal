defmodule NervesCaptivePortalWeb.PageController do
  use NervesCaptivePortalWeb, :controller

  def captive_portal_api(conn, _params) do
    conn
    |> put_resp_content_type("application/captive+json")
    |> json(%{
      captive: captive?(),
      "user-portal-url": portal_url(),
    })
  end

  defp captive?() do
    portal_fun = Application.get_env(:nerves_captive_portal, :captive_fun)
    case portal_fun do
      fun when is_function(fun, 0) ->
        fun.()
      {module, method} ->
        apply(module, method, [])
    end
  end

  defp portal_url() do
    Application.get_env(:nerves_captive_portal, :portal_url, "http://captive.portal/")
  end
end
