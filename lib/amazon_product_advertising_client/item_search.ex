defmodule AmazonProductAdvertisingClient.ItemSearch do
  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config

  def __struct__ do
    %{
      "Availability"  => "Available",
      "BrowseNode"    => nil,
      "Condition"     => "New",
      "Keywords"      => nil,
      "Operation"     => "ItemSearch",
      "MaximumPrice"  => nil,
      "MinimumPrice"  => nil,
      "ResponseGroup" => nil,
      "SearchIndex"   => nil,
      "ResponseGroup" => nil,
      "Title"         => nil,
      "Sort"          => nil,
    }
  end

  def execute(search_params \\ %ItemSearch{}, config \\ %Config{}) do
    AmazonProductAdvertisingClient.call_api search_params, config
  end
end
