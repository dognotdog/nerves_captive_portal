# NervesCaptivePortal


## Cert Generation

Config similar to [this post](https://medium.com/@antelle/how-to-generate-a-self-signed-ssl-certificate-for-an-ip-address-f0dd8dddf754).

`portal-cert.config` contains the necessary OpenSSL config, and the key/cert pair can be generated with
```bash
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout priv/ssl/portal-key.pem -out priv/ssl/portal-cert.pem -config portal-cert.config
```

## Usage

The captive portal according to RFC8910 and RFC8908 is made up of two components: a special DHCP option that advertises the captive portal API, and the captive portal API itself. The API must run as HTTPS, and uses a self signed certificate, but apart from the basic JSON data it doesn't have to provide any further functionality.

The API uses the `application/captive+json` MIME type.

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
