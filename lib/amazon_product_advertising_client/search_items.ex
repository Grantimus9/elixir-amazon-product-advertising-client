defmodule AmazonProductAdvertisingClient.SearchItems do
  @moduledoc """
  The [SearchItems](https://webservices.amazon.com/paapi5/documentation/search-items.html) operation
  """

  alias AmazonProductAdvertisingClient.{SearchItems, Config}

  defstruct(
    "Actor": nil,
    "Artist": nil,
    "Author": nil,
    "Availability": nil,
    "Brand": nil,
    "BrowseNodeId": nil,
    "Condition": nil,
    "CurrencyOfPreference": nil,
    "DeliveryFlags": nil,
    "ItemCount": nil,
    "ItemPage": nil,
    "Keywords": nil,
    "LanguagesOfPreference": nil,
    "MaxPrice": nil,
    "Merchant": nil,
    "MinPrice": nil,
    "MinReviewsRating": nil,
    "MinSavingPercent": nil,
    "OfferCount": nil,
    "Properties": nil,
    "Resources": nil,
    "SearchIndex": nil,
    "SortBy": nil,
    "Title": nil
  )

  @doc """
  Execute a SearchItems operation
  """
  def execute(params \\ %SearchItems{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api(
      "com.amazon.paapi5.v1.ProductAdvertisingAPIv1.SearchItems",
      "/paapi5/searchitems",
      params,
      config
    )
  end
end
