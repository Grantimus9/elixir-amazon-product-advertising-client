defmodule AmazonProductAdvertisingClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :amazon_product_advertising_client,
      version: "0.3.0",
      elixir: "~> 1.4",
      description: "An Amazon Product Advertising API client for Elixir",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:jason, "~> 1.0"},
      {:httpoison, "~> 1.0"},
      {:timex, "~> 3.1"}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/keslert/elixir-amazon-product-advertising-client"
      },
      maintainers: ["Kesler Tanner <keslert@gmail.com>"],
      source_url: "https://github.com/keslert/elixir-amazon-product-advertising-client"
    ]
  end
end
