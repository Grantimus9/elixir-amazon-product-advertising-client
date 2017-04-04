Amazon Product Advertising Client
================================

[![Build Status](https://travis-ci.org/zachgarwood/elixir-amazon-product-advertising-client.svg?branch=master)](https://travis-ci.org/zachgarwood/elixir-amazon-product-advertising-client)

## Configure
Add your AWS authentication credentials to `config/config.exs`:

```elixir
config :amazon_product_advertising_client,
  associate_tag: "YourAssociateTag",
  aws_access_key_id: "YourAccessKeyID",
  aws_secret_access_key: "YourSecretAccessKey",
  marketplace_host: "webservices.amazon.ca" # If not specified the default value is webservices.amazon.com
```

## Usage
Create a search params struct and execute the search, for example:

```elixir
alias AmazonProductAdvertisingClient.ItemSearch

def search_for_item do
  %ItemSearch{"MaximumPrice": "25", "Keywords": "long sleeve shirt"} |> ItemSearch.execute
end
```
