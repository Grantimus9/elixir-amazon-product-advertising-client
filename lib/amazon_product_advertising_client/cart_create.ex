defmodule AmazonProductAdvertisingClient.CartCreate do
  @moduledoc """
  The [CartCreate](http://docs.aws.amazon.com/AWSECommerceService/latest/DG/CartCreate.html) operation


  """

  alias __MODULE__
  alias AmazonProductAdvertisingClient.Config

  defstruct "Condition": "All",
      "Items": nil, # Required list of objects [%{"ASIN" => "B00RVJFSOQ", "Quantity" => 1}...]
      "Operation": "CartCreate"

  def format_item_params(items) do
    items |> Enum.with_index |> Enum.reduce(%{}, fn({item,i}, acc) -> 
      Map.merge(acc, 
        Enum.reduce(item, %{}, fn({k,v}, acc) ->
          Map.put(acc, "Item.#{i+1}.#{k}", v)
        end)
      ) 
    end)
  end


  @doc """
  Execute a CartCreate execution
  """
  def execute(search_params \\ %CartCreate{}, config \\ %Config{}) do
    map_params = Map.from_struct(search_params)
    # IO.inspect(map_params[:Items])
    #IO.inspect(format_item_params(map_params[:Items]))

    formatted_params = Map.merge(format_item_params(map_params[:Items]), Map.delete(map_params, :Items))
    AmazonProductAdvertisingClient.call_api formatted_params,  Map.from_struct(config)
  end
end