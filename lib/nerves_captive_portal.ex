defmodule NervesCaptivePortal do
  @moduledoc """
  NervesCaptivePortal helpers. 
  """

  @doc """
  Modify a `VintageNet` network config with RFC8910 captive portal fields. Irrespective of the captive portal being currently active, if one exists it should always provide the right URL. For networks without a captive portal, the respective `114` option is also provided, to save user clients the trouble of trying alternate forms of captive portal discovery.

  Options:
   - `:captive_portal_api_host` is the portal's host name or IP addr (has to match certificate records!), default is "captive.portal"
   - `:captive_portal_api_port` is the portal's port, default is 4001

  """
  def modify_network_config(config, captive_portal?, opts \\ []) do
    if captive_portal? do
      api_host = Keyword.get(opts, :captive_portal_api_host, "captive.portal")
      api_port = Keyword.get(opts, :captive_portal_api_port, 4001)
      dnsd_records = Access.get(config[:dnsd], :records, [])
      [router_addr] = config[:dhcpd][:options][:router]

      # DHCPD option string needs to include quotes, hence the ~s("...")
      config
      |> put_in([:dhcpd, :options, 114], ~s("https://#{api_host}:#{api_port}/captive-portal/api"))
      |> put_in([:dnsd, :records], [ {api_host, router_addr} | dnsd_records])
    else
      config
      |> put_in([:dhcpd, :options, 114], ~s("urn:ietf:params:capport:unrestricted"))
    end
  end
end
