defmodule AmazonProductAdvertisingClient.Config do
  @moduledoc """
  The configuration used for authorizing and versioning API requests.
  """

  defstruct "AssociateTag": Application.get_env(:amazon_product_advertising_client, :associate_tag),
    "AWSAccessKeyId": Application.get_env(:amazon_product_advertising_client, :aws_access_key_id),
    "Service": "AWSECommerceService",
    "Version": "2013-08-01"
end
