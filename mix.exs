defmodule NervesTime.RTC.Abracon.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://github.com/nerves-time/nerves_time_rtc_abracon"

  def project do
    [
      app: :nerves_time_rtc_abracon,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: @source_url,
      docs: docs(),
      dialyzer: [
        flags: [:unmatched_returns, :error_handling, :race_conditions, :underspecs]
      ],
      deps: deps(),
      preferred_cli_env: %{
        docs: :docs,
        "hex.publish": :docs,
        "hex.build": :docs
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "NervesTime.RTC implementation for Abracon Real-time Clocks"
  end

  defp package do
    %{
      files: [
        "lib",
        "test",
        "mix.exs",
        "README.md",
        "LICENSE",
        "CHANGELOG.md"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    }
  end

  defp deps do
    [
      {:circuits_i2c, "~> 0.3.6"},
      {:nerves_time, "~> 0.4.1"},
      {:ex_doc, "~> 0.19", only: [:docs], runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end

  def docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
