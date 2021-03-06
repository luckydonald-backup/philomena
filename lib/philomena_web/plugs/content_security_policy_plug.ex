defmodule PhilomenaWeb.ContentSecurityPolicyPlug do
  alias Plug.Conn

  def init([]) do
    cdn_uri = cdn_uri()
    camo_uri = camo_uri()

    csp_value =
      "default-src 'self' #{cdn_uri}; object-src 'none'; " <>
      "frame-ancestors 'none'; frame-src 'none'; form-action 'self'; " <>
      "manifest-src 'self'; img-src 'self' data: #{cdn_uri} #{camo_uri}; " <>
      "block-all-mixed-content"

    [csp_value: csp_value]
  end

  def call(conn, [csp_value: csp_value]) do
    Conn.put_resp_header(conn, "Content-Security-Policy", csp_value)
  end

  defp cdn_uri, do: Application.get_env(:philomena, :cdn_host) |> to_uri()
  defp camo_uri, do: Application.get_env(:philomena, :camo_host) |> to_uri()

  defp to_uri(host) when host in [nil, ""], do: ""
  defp to_uri(host), do: URI.to_string(%URI{scheme: "https", host: host})
end