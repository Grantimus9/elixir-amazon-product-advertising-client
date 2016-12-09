defmodule AmazonProductAdvertisingClient.ItemSearch do
  @moduledoc false

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
      "Title": nil

  def execute(search_params \\ %ItemSearch{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
