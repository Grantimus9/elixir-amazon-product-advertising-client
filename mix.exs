defmodule AmazonProductAdvertisingClient.Mixfile do
  use Mix.Project

  def project do
    [app: :amazon_product_advertising_client,
     version: "0.1.1",
     elixir: "~> 1.0",
     description: "An Amazon Product Advertising API client for Elixir",
     package: package,
     deps: deps]
  end

  def application do
    [
      applications: [
        :httpoison,
        :logger,
        :tzdata,
      ]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9"},
      {:sweet_xml, "~> 0.6"},
      {:timex, "~> 3.0"},
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/zachgarwood/elixir-amazon-product-advertising-client"},
      maintainers: ["Zach Garwood <zachgarwood@gmail.com>"]
    ]
  end
end
