defmodule AmazonProductAdvertisingClient do
  alias AmazonProductAdvertisingClient.Config

  use HTTPoison.Base
  use Timex

  @scheme "http"
  @host   "webservices.amazon.com"
  @path   "/onca/xml"

  def call_api(request_params, config \\ %Config{}) do
    query = [request_params, config] |> combine_params |> URI.encode_query
    get %URI{scheme: @scheme, host: @host, path: @path, query: query}
  end

  defp combine_params(params_list) do
    List.foldl params_list, Map.new, fn(params, all_params) ->
      Map.merge Map.from_struct(params), all_params
    end
  end

  def process_url(url) do
    url |> URI.parse |> timestamp_url |> sign_url |> String.Chars.to_string
  end

  defp timestamp_url(url_parts) do
    timestamped_query = url_parts.query
                        |> URI.decode_query
                        |> Map.put_new("Timestamp", DateFormat.format!(Date.local, "{ISOz}"))
                        |> URI.encode_query
    Map.put url_parts, :query, timestamped_query
  end

  defp sign_url(url_parts) do
    ordered_query = url_parts.query |> URI.decode_query |> Enum.sort |> URI.encode_query
    signature =
      :crypto.hmac(
        :sha256,
        Application.get_env(:amazon_product_advertising_client, :aws_secret_access_key),
        Enum.join(["GET", url_parts.host, url_parts.path, ordered_query], "\n")
      )
      |> Base.encode64
      |> URI.encode_www_form
    signed_query = "#{url_parts.query}&Signature=#{signature}"
    Map.put url_parts, :query, signed_query
  end
end
