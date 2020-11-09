defmodule SieveOfAtkin.MixProject do
  use Mix.Project

  @source_url "https://github.com/Cantido/sieve_of_atkin"

  def project do
    [
      name: "SieveOfAtkin",
      description: "Generates prime numbers using the Sieve of Atkin algorithm.",
      package: package(),
      app: :sieve_of_atkin,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      source_url: @source_url,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Rosa Richter"],
      licenses: ["MIT"],
      links: %{"Github" => @source_url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:flow, "~> 1.0"}
    ]
  end
end
