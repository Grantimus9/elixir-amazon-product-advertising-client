defmodule AmazonProductAdvertisingClient.ItemLookup do
  @moduledoc false

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config
  defstruct "Availability": "Available",
    "ItemId": nil,
    "Operation": "ItemLookup",
    "ResponseGroup": "ItemAttributes,Images",
    "idType": "ASIN"

  def execute(search_params \\ %ItemLookup{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
