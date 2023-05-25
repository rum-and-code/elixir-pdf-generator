defmodule PdfGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :pdf_generator,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_utils, git: "git@github.com:rum-and-code/elixir-utils.git"},
      {:httpoison, "~> 2.1"}
    ]
  end
end
