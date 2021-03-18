Amazon Product Advertising Client
================================

https://webservices.amazon.com/paapi5/documentation

## Configure
Add your AWS authentication credentials to `config/config.exs`:

Hex: https://hex.pm/packages/amazon_product_advertising_client

```elixir
  # in your mix.exs
  {:amazon_product_advertising_client, "~> 0.3.0"}
```

```elixir

# in your config/config.exs
config :amazon_product_advertising_client,
  associate_tag: "YourAssociateTag",
  aws_access_key_id: "YourAccessKeyID",
  aws_secret_access_key: "YourSecretAccessKey",
  marketplace_host: "webservices.amazon.ca" # If not specified the default value is webservices.amazon.com

```

## Usage and Examples

### GetItems
```elixir

alias AmazonProductAdvertisingClient.GetItems
# Lookup by ASIN
def lookup_by_asin(asin) when is_binary(asin) do
  %GetItems{ItemIds: [asin]}
  |> GetItems.execute()
end

```

### SearchItems

An example of searching by ISBN
```elixir

alias AmazonProductAdvertisingClient.SearchItems

# e.g. an ISBN of "9781680502992"
def lookup_book_info(isbn) when is_binary(isbn) do
  lookup_struct = %SearchItems{Keywords: isbn}

  case SearchItems.execute(lookup_struct) do
    {:ok, %HTTPoison.Response{body: body}} ->
      body |> Jason.decode!()
  end

end

```
