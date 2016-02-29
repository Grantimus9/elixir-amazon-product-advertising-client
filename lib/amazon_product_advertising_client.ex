defmodule AmazonProductAdvertisingClient do
  alias AmazonProductAdvertisingClient.Config

  use HTTPoison.Base
  use Timex

  @scheme "http"
  @host   "webservices.amazon.com"
  @path   "/onca/xml"

  def call_api(request_params, config \\ %Config{}) do
    query = [request_params, config] |> combine_params |> percent_encode_query
    get %URI{scheme: @scheme, host: @host, path: @path, query: query}
  end

  defp combine_params(params_list) do
    List.foldl params_list, Map.new, fn(params, all_params) ->
      Map.merge Map.from_struct(params), all_params
    end
  end

  @doc """
  `URI.encode_query/1` explicitly does not percent-encode spaces, but Amazon requires `%20`
  instead of `+` in the query, so we essentially have to rewrite `URI.encode_query/1` and
  `URI.pair/1`.
  """
  defp percent_encode_query(query_map) do
    Enum.map_join(query_map, "&", &pair/1)
  end

  @doc """
  See comment on `percent_encode_query/1`.
  """
  defp pair({k, v}) do
    URI.encode(Kernel.to_string(k), &URI.char_unreserved?/1) <>
    "=" <> URI.encode(Kernel.to_string(v), &URI.char_unreserved?/1)
  end

  def process_url(url) do
    url |> URI.parse |> timestamp_url |> sign_url |> String.Chars.to_string
  end

  defp timestamp_url(url_parts) do
    timestamped_query = url_parts.query
                        |> URI.decode_query
                        |> Map.put_new("Timestamp", DateFormat.format!(Date.local, "{ISOz}"))
                        |> percent_encode_query
    Map.put url_parts, :query, timestamped_query
  end

  defp sign_url(url_parts) do
    query = URI.decode_query url_parts.query

    # If the query already has a Signature param, don't calculate the signature.
    # (This is mostly for testing purposes).
    signature = if Map.has_key? query, "Signature" do
      {signature_value, query} = Map.pop query, "Signature" 
      query = percent_encode_query query
      signature_value
    else
      query = percent_encode_query query
      :crypto.hmac(
        :sha256,
        Application.get_env(:amazon_product_advertising_client, :aws_secret_access_key),
        Enum.join(["GET", url_parts.host, url_parts.path, query], "\n")
      )
      |> Base.encode64
      |> URI.encode_www_form
    end
    signed_query = "#{query}&Signature=#{signature}"
    Map.put url_parts, :query, signed_query
  end
end
