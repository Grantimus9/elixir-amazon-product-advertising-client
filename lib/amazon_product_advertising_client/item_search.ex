defmodule AmazonProductAdvertisingClient.ItemSearch do
  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config
  defstruct "Availability": "Available",
      "BrowseNode": nil,
      "BrowseNodeId": nil,
      "Condition": "New",
      "ItemPage": nil,
      "Keywords": nil,
      "Operation": "ItemSearch",
      "MaximumPrice": nil,
      "MinimumPrice": nil,
      "ResponseGroup": nil,
      "SearchIndex": nil,
      "Sort": nil,
      "ResponseGroup": nil,
      "Title": nil

  def execute(search_params \\ %ItemSearch{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
