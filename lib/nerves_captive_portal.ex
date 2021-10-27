defmodule NervesCaptivePortal do
  @moduledoc """
  NervesCaptivePortal provides functions to 
  """

  @doc """
  Modify a `VintageNet` network config with RFC8910 captive portal fields. Irrespective of the captive portal being currently active, if one exists it should always provide the right URL. For networks without a captive portal, the respective `114` option is also provided, to save user clients the trouble of trying alternate forms of captive portal discovery.
  """
  def modify_network_config(config, captive_portal?) do
    if captive_portal? do
      put_in(config, [:dhcpd, :options, 114], "https://captive.portal/captive-portal/api")
      dnsd_records = Access.get(config[:dnsd], :records, [])
      [router_addr] = config[:dhcpd][:options][:router]
      put_in(config, [:dnsd, :records], [ {"captive.portal", router_addr} | dnsd_records])
    else
      put_in(config, [:dhcpd, :options, 114], "urn:ietf:params:capport:unrestricted")
    end
  end
end
