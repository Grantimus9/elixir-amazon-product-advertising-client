defmodule AmazonProductAdvertisingClient.ItemSearch do
  @moduledoc """
  The [ItemSearch](http://docs.aws.amazon.com/AWSECommerceService/latest/DG/ItemSearch.html) operation

  """

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config

  defstruct "Availability": "Available",
      "BrowseNode": nil,
      "BrowseNodeId": nil,
      "Condition": "New",
      "ItemPage": nil,
      "Keywords": nil,
      "MaximumPrice": nil,
      "MinimumPrice": nil,
      "Operation": "ItemSearch",
      "ResponseGroup": nil,
      "SearchIndex": nil,
      "Sort": nil,
      "Title": nil,
      "MerchantId": nil

  @doc """
  Execute an ItemSearch operation
  """
  def execute(search_params \\ %ItemSearch{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
