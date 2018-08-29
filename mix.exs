defmodule AmazonProductAdvertisingClient.Mixfile do
  use Mix.Project

  def project do
    [app: :amazon_product_advertising_client,
     version: "0.2.2",
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
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:httpoison, "~> 1.0"},
      {:sweet_xml, "~> 0.6"},
      {:timex, "~> 3.1"},
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Grantimus9/elixir-amazon-product-advertising-client"},
      maintainers: ["Grant Nelson <grantmnelsn+oss@gmail.com>"],
      source_url: "https://github.com/Grantimus9/elixir-amazon-product-advertising-client"
    ]
  end
end
