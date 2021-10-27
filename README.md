# NervesCaptivePortal


## Cert Generation

Config similar to [this post](https://medium.com/@antelle/how-to-generate-a-self-signed-ssl-certificate-for-an-ip-address-f0dd8dddf754).

`portal-cert.config` contains the necessary OpenSSL config, and the key/cert pair can be generated with
```bash
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout priv/ssl/portal-key.pem -out priv/ssl/portal-cert.pem -config portal-cert.config
```

Note: the cert is valid for 10 years, if that's not long enough regenerate it with more `-days`.

## Usage

The captive portal according to RFC8910 and RFC8908 is made up of two components: a special DHCP option that advertises the captive portal API, and the captive portal API itself. The API must run as HTTPS, and uses a self signed certificate, but apart from the basic JSON data it doesn't have to provide any further functionality.

The API uses the `application/captive+json` MIME type.

When the captive portal routing is configured, assumed as IPv4 DHCP, `NervesCaptivePortal.modify_network_config(config, captive_portal?)` can be used add RFC8910 compliant information to a `VintageNet` interface configuration.

### Config

The `:nerves_captive_portal` config can be used for setting up the portal API. The endpoint config should not have to be changed, but the actual portal URL and state indicating function can be set.

```elixir
# Configures the endpoint
config :nerves_captive_portal, NervesCaptivePortalWeb.Endpoint,
  url: [host: "captive.portal"],
  https: [
    port: 4001,
    otp_app: :nerves_captive_portal,
    keyfile: "priv/ssl/portal-key.pem",
    certfile: "priv/ssl/portal-cert.pem",
  ]

# :captive_fun can either be
# - a captured function/0
# - a {module, method} tuple
# to indicate if the user needs to interact with the portal
config :nerves_captive_portal,
  user_portal_url: "http://captive.portal/",
  captive_fun: fn -> true end
```

# Phoenix Info

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4001`](https://localhost:4001) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
