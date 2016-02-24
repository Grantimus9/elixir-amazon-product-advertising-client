defmodule AmazonProductAdvertisingClient do
  alias AmazonProductAdvertisingClient.Config

  use HTTPoison.Base
  use Timex

  @scheme "http"
  @host   "webservices.amazon.com"
  @path   "/onca/xml"

  def call_api(request_params, config \\ %Config{}) do
    query = [request_params, config] |> combine |> Map.merge(timestamp) |> parameterize
    signature = compute_signuature(query)

    get %URI{scheme: @scheme, host: @host, path: @path, query: "#{query}&Signature=#{signature}"}
  end

  defp timestamp do
    %{"Timestamp" => DateFormat.format!(Date.local, "{ISOz}")}
  end

  defp combine(params_list) do
    List.foldl params_list, Map.new, fn(params, all_params) ->
      Map.merge Map.from_struct(params), all_params
    end
  end

  def parameterize(params) do
    params |> Enum.map(fn({key, value}) -> "#{key}=#{encode value}" end) |> Enum.sort |> Enum.join("&")
  end

  defp compute_signuature(query) do
    :crypto.hmac(
      :sha256,
      Application.get_env(:amazon_product_advertising_client, :aws_secret_access_key),
      Enum.join(["GET", @host, @path, query], "\n")
    )
    |> Base.encode64
    |> URI.encode_www_form
  end

  defp encode(value) when is_bitstring(value) do
    URI.encode(value, &URI.char_unreserved?/1)
  end

  defp encode(_) do
    ""
  end
end
