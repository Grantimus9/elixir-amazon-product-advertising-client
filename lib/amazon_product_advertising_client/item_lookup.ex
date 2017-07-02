defmodule AmazonProductAdvertisingClient.ItemLookup do
  @moduledoc """
  The [ItemLookup](http://docs.aws.amazon.com/AWSECommerceService/latest/DG/ItemLookup.html) operation
  """

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config

  defstruct "Condition": "New",
    "IdType": "ASIN",
    "IncludeReviewsSummary": nil,
    "ItemId": nil,
    "MerchantId": nil,
    "Operation": "ItemLookup",
    "RelatedItemPage": nil,
    "RelationshipType": nil,
    "ResponseGroup": "ItemAttributes,Images",
    "SearchIndex": nil,
    "TruncateReviewsAt": nil,
    "VariationPage": nil

  @doc """
  Execute an ItemLookup operation
  """
  def execute(search_params \\ %ItemLookup{}, config \\ %Config{}, host) do
    AmazonProductAdvertisingClient.call_api search_params, config, host
  end
end
