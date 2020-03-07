defmodule AmazonProductAdvertisingClient do
  @moduledoc """
  An Amazon Product Advertising API client for Elixir
  """

  use Timex
  alias AmazonProductAdvertisingClient.Config

  @scheme "https"
  @host Application.get_env(:amazon_product_advertising_client, :marketplace_host, "webservices.amazon.com")
  @aws4_request "aws4_request"
  @hmac_algorithm "AWS4-HMAC-SHA256"
  @service_name "ProductAdvertisingAPI"

  @doc """
  Make a call to the API with the specified request parameters.
  """
  def call_api(target, path, payload_params, config \\ %Config{}) do
    payload = [payload_params, config] |> combine_params |> Jason.encode!()
    date = Timex.now()
    opts = %{
      method_name: "POST",
      region_name: "us-east-1",
      payload: payload,
      target: target,
      path: path,
      date: Timex.format!(date, "%Y%m%d", :strftime),
      timestamp: Timex.format!(date, "%Y%m%dT%H%M%SZ", :strftime),
    }

    uri = %URI{scheme: @scheme, host: @host, path: path}
    headers = build_headers(opts)
    HTTPoison.post(uri, payload, headers)
  end

  defp combine_params(params_list) do
    List.foldr(params_list, %{}, fn(params, all_params) ->
      Map.merge(all_params, Map.from_struct(params))
    end)
    |> Enum.filter(fn {_, v} -> v end)
    |> Enum.into(%{})
  end

  defp build_headers(opts) do
    headers = [
      {"content-encoding", "amz-1.0"},
      {"content-type", "application/json; charset=utf-8"},
      {"host", @host},
      {"x-amz-date", opts.timestamp},
      {"x-amz-target", opts.target},
    ]
    # Note: At this point, headers must be sorted alphabetically

    {canonical_url, signed_headers} = prepare_canonical_request(headers, opts);
    string_to_sign = prepare_string_to_sign(canonical_url, opts)

    signature = calculate_signature(string_to_sign, opts)
    authorization = build_authorization_string(signature, signed_headers, opts)

    headers ++ [{"Authorization", authorization}]
  end

  defp prepare_canonical_request(headers, opts) do
    headers_string = Enum.map(headers, fn {k, v} -> "#{k}:#{v}" end) |> Enum.join("\n")
    signed_header = Enum.map(headers, &elem(&1, 0)) |> Enum.join(";")

    canonical_url = ""
      <> opts.method_name <> "\n"
      <> opts.path <> "\n\n"
      <> headers_string <> "\n\n"
      <> signed_header <> "\n"
      <> generate_hex(opts.payload)

    {canonical_url, signed_header}
  end

  defp prepare_string_to_sign(canonical_url, opts) do
    ""
    <> @hmac_algorithm <> "\n"
    <> opts.timestamp <> "\n"
    <> opts.date <> "/" <> opts.region_name <> "/" <> @service_name <> "/" <> @aws4_request <> "\n"
    <> generate_hex(canonical_url)
  end

  defp calculate_signature(string_to_sign, opts) do
    signature_key = get_signature_key(opts)

    :crypto.hmac(:sha256, signature_key, string_to_sign)
    |> Base.encode16(case: :lower)
  end

  defp build_authorization_string(signature, signed_headers, opts) do
    access_key = Application.get_env(:amazon_product_advertising_client, :aws_access_key_id)
    "#{@hmac_algorithm} Credential=#{access_key}/#{opts.date}/#{opts.region_name}/#{@service_name}/#{@aws4_request}, SignedHeaders=#{signed_headers}, Signature=#{signature}"
  end

  defp generate_hex(data) do
    :crypto.hash(:sha256, data)
    |> Base.encode16(case: :lower)
  end

  defp get_signature_key(opts) do
    key = Application.get_env(:amazon_product_advertising_client, :aws_secret_access_key)
    k_secret = "AWS4" <> key
    k_date = :crypto.hmac(:sha256, k_secret, opts.date)
    k_region = :crypto.hmac(:sha256, k_date, opts.region_name)
    k_service = :crypto.hmac(:sha256, k_region, @service_name)

    :crypto.hmac(:sha256, k_service, @aws4_request)
  end
end
