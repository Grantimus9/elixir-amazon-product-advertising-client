defmodule AmazonProductAdvertisingClient.Mixfile do
  use Mix.Project

  def project do
    [app: :amazon_product_advertising_client,
     version: "0.1.0",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :tzdata]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.1"},
      {:sweet_xml, "~> 0.6.1"},
      {:timex, "~> 1.0"}
    ]
  end
end
