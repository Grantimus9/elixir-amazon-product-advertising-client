defmodule AmazonProductAdvertisingClient.ItemLookup do
  @moduledoc false

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config
  defstruct "Condition": "New",
    "IncludeReviewsSummary": nil,
    "MerchantId": nil,
    "ItemId": nil,
    "Operation": "ItemLookup",
    "RelatedItemPage": nil,
    "RelationshipType": nil,
    "SearchIndex": nil,
    "TruncateReviewsAt": nil,
    "VariationPage": nil,
    "ResponseGroup": "ItemAttributes,Images",
    "IdType": "ASIN"

  def execute(search_params \\ %ItemLookup{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
