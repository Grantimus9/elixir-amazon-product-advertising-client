defmodule AmazonProductAdvertisingClient.Mixfile do
  use Mix.Project

  def project do
    [app: :amazon_product_advertising_client,
     version: "0.2.0",
     elixir: "~> 1.4",
     description: "An Amazon Product Advertising API client for Elixir",
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:dogma, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev},
      {:httpoison, "~> 0.11"},
      {:sweet_xml, "~> 0.6"},
      {:timex, "~> 3.1"},
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
