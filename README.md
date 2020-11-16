Amazon Product Advertising Client
================================

## Configure
Add your AWS authentication credentials to `config/config.exs`:

Hex: https://hex.pm/packages/amazon_product_advertising_client

```elixir

  # in your mix.exs
  {:amazon_product_advertising_client, "~> 0.2.1"}

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

Both of the functions return an %HTTPoison.Response{} struct. This Amazon API responds with XML, so you will most likely want
to parse the body using a library such as SweetXml.

### Search
Create a search params struct and execute the search, for example:

```elixir

alias AmazonProductAdvertisingClient.ItemSearch

def search_for_item do
  %ItemSearch{"MaximumPrice": "25", "Keywords": "long sleeve shirt"} |> ItemSearch.execute
end

```

### Lookup
```elixir

alias AmazonProductAdvertisingClient.ItemLookup

# e.g. an ISBN of 9781680502992
def lookup_book_by_isbn(isbn) do
  %ItemLookup{
      IdType: "ISBN",
      ItemId: isbn,
      SearchIndex: "Books"}
  |> ItemLookup.execute()
end

```

### Lookup and Parse Response
```elixir

# Modules needed.
alias AmazonProductAdvertisingClient.ItemLookup
import SweetXml

# Returns a map with 'title' and 'detail_page_url' keys
def lookup_book_info(isbn) do
  lookup_struct =
    %ItemLookup{
      IdType: "ISBN",
      ItemId: isbn,
      SearchIndex: "Books"}

  case ItemLookup.execute(lookup_struct) do
    {:ok, %HTTPoison.Response{body: body}} ->
      body |> parse_xml_body()
  end

end

# The XML response from Amazon is voluminous. There are many fields to retrieve,
# for this example we pull the book's title and Amazon URL.
def parse_xml_body(body) do
  body
  |> SweetXml.xmap(
    title: ~x"//ItemLookupResponse/Items/Item/ItemAttributes/Title/text()",
    detail_page_url: ~x"//ItemLookupResponse/Items/Item/DetailPageURL/text()",
    )
end

```
