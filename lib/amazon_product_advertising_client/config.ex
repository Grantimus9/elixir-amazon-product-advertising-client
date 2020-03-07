defmodule AmazonProductAdvertisingClient.Config do
  @moduledoc """
  The configuration used for authorizing and versioning API requests.
  """
  defstruct(
    PartnerTag: Application.get_env(:amazon_product_advertising_client, :associate_tag),
    PartnerType: "Associates",
    Marketplace: "www.amazon.com"
  )
end
