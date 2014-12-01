defmodule AmazonProductAdvertisingClient do
  use HTTPoison.Base
  use Timex

  @url "http://webservices.amazon.com/onca/xml"
  @params %{
    "Service"         => "AWSECommerceService",
    "Version"         => "2013-08-01",
    "AWSAccessKeyId"  => Application.get_env(:amazon_product_advertising_client, :aws_access_key_id),
    "AssociateTag"    => Application.get_env(:amazon_product_advertising_client, :associate_tag),
  }

  def item_search(search_term) do
    call_api %{"Operation" => "ItemSearch", "SearchIndex" => "Apparel", "Keywords" => search_term} 
  end

  def process_url(url) do
    sign_request url
  end

  defp call_api(params) do
    params = Map.put params, "Timestamp", DateFormat.format!(Date.local, "{ISOz}")
    query = Map.merge(@params, params) |> Enum.sort |> URI.encode_query
    get "#{@url}?#{query}"
  end

  defp sign_request(url) do
    signature =
      :crypto.hmac(
        :sha256,
        Application.get_env(:amazon_product_advertising_client, :aws_secret_access_key),
        construct_request url
      )
      |> Base.encode64
      |> URI.encode_www_form
    "#{url}&Signature=#{signature}"
  end

  defp construct_request(url) do
    url_parts = URI.parse url
    Enum.join ["GET", url_parts.host, url_parts.path, url_parts.query], "\n"
  end
end
