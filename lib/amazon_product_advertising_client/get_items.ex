defmodule AmazonProductAdvertisingClient.GetItems do
  @moduledoc """
  The [GetItems](https://webservices.amazon.com/paapi5/documentation/get-items.html) operation
  """

  alias AmazonProductAdvertisingClient.{GetItems, Config}

  defstruct(
    "ItemIds": nil,
    "ItemIdType": nil,

    "Condition": nil,
    "CurrencyOfPreference": nil,
    "LanguagesOfPreference": nil,
    "Merchant": nil,
    "OfferCount": nil,
    "Properties": nil,
    "Resources": nil
  )

  @doc """
  Execute a GetItems operation
  """
  def execute(params \\ %GetItems{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api(
      "com.amazon.paapi5.v1.ProductAdvertisingAPIv1.GetItems",
      "/paapi5/getitems",
      params,
      config
    )
  end
end
