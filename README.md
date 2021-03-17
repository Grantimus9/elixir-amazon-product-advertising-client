Amazon Product Advertising Client
================================

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

### Lookup
```elixir

alias AmazonProductAdvertisingClient.GetItems

# e.g. an ISBN of 9781680502992
def lookup_book_by_isbn(isbn) do
  %GetItems{ItemIds: [isbn]}
  |> GetItems.execute()
end

```

### Lookup and Parse Response
```elixir

# Modules needed.
alias AmazonProductAdvertisingClient.GetItems

# Returns a map with 'title' and 'detail_page_url' keys
def lookup_book_info(isbn) do
  lookup_struct = GetItems{ItemIds: [isbn]}

  case GetItems.execute(lookup_struct) do
    {:ok, %HTTPoison.Response{body: body}} ->
      body |> Jase.decodde!()
  end

end

```
