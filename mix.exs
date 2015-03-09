defmodule ExBump.Mixfile do
  use Mix.Project

  def project do
    [app: :bump,
     version: "0.1.0",
     elixir: "1.0.3",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  defp description do
    """
    A library for writing BMP files from binary data.
    """
  end

  defp package do
    [contributors: ["Evan Farrar"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/evanfarrar/ex_bump"}]
  end
end
