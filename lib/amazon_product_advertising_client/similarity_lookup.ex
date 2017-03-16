defmodule AmazonProductAdvertisingClient.SimilarityLookup do
  @moduledoc """
  The [SimilarityLookup](http://docs.aws.amazon.com/AWSECommerceService/latest/DG/SimilarityLookup.html) operation


  """

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config

  defstruct "Condition": "All",
      "ItemId": nil, # Required ASIN - Can include up to ten comma-separated IDs
      "MerchantId": nil,
      "Operation": "SimilarityLookup",
      "ResponseGroup": nil,
      "SimilarityType": "Intersection" # Or, Random

  @doc """
  Execute a SimilaryLookup operation
  """
  def execute(search_params \\ %SimilarityLookup{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
