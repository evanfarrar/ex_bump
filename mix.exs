defmodule ExBump.Mixfile do
  use Mix.Project

  def project do
    [app: :,
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
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README", "LICENSE"],
     contributors: ["Evan Farrar"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/evanfarrar/ex_bump"}]
  end
end
