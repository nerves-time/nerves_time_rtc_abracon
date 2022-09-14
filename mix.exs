defmodule NervesTime.RTC.Abracon.MixProject do
  use Mix.Project

  @version "0.2.1"
  @source_url "https://github.com/nerves-time/nerves_time_rtc_abracon"

  def project do
    [
      app: :nerves_time_rtc_abracon,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: @source_url,
      docs: docs(),
      dialyzer: [
        flags: [:unmatched_returns, :error_handling, :missing_return, :extra_return, :underspecs]
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
      links: %{
        "GitHub" => @source_url,
        "AB-RTCMC-32.768kHz-IBO5-S3" =>
          "https://abracon.com/Support/AppsManuals/Precisiontiming/Application%20Manual%20AB-RTCMC-32.768kHz-IBO5-S3.pdf",
        "AB-RTCMC-32.768kHz-B5ZE-S3" =>
          "https://abracon.com/realtimeclock/AB-RTCMC-32.768kHz-B5ZE-S3-Application-Manual.pdf"
      }
    }
  end

  defp deps do
    [
      {:circuits_i2c, "~> 0.3 or ~> 1.0"},
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
