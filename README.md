# NervesTime.RTC.Abracon

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

And then update your `:nerves_time` configuration to point to it:

```elixir
config :nerves_time, rtc: NervesTime.RTC.Abracon
```

It's possible to override the default I2C bus and address via options:

```elixir
config :nerves_time, rtc: {NervesTime.RTC.Abracon, [bus_name: "i2c-2", address:
0x69]}
```

Check the logs for error messages if the RTC doesn't appear to work.
