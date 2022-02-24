# NervesTime.RTC.Abracon

[![CircleCI](https://circleci.com/gh/nerves-time/nerves_time_rtc_abracon.svg?style=svg)](https://circleci.com/gh/nerves-time/nerves_time_rtc_abracon)
[![Hex version](https://img.shields.io/hexpm/v/nerves_time_rtc_abracon.svg "Hex version")](https://hex.pm/packages/nerves_time_rtc_abracon)

NervesTime.RTC implementation for common Abracon Real-time clock modules. The
following are supported:

* [AB-RTCMC-32.768kHz-IBO5-S3](https://abracon.com/realtimeclock/AB-RTCMC-32.768kHz-IBO5-S3.pdf)

## Using

First add this project to your `mix` dependencies:

```elixir
def deps do
  [
    {:nerves_time_rtc_abracon, "~> 0.1.0"}
  ]
end
```

And then update your `:nerves_time` configuration to point to your module type:

```elixir
config :nerves_time, rtc: NervesTime.RTC.Abracon.IBO5
```

It's possible to override the default I2C bus and address via options:

```elixir
config :nerves_time, rtc: {NervesTime.RTC.Abracon.IBO5, [bus_name: "i2c-2", address:
0x69]}
```

Check the logs for error messages if the RTC doesn't appear to work.
