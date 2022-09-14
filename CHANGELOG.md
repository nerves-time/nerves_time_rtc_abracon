# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.3.0] - 2022-09-14

### Added

* AB0805-T3 support with `NervesTime.RTC.Abrocon.AB0805

### Removed

* Elixir 1.10 and earlier are no longer supported and will produce a warning if
  used.

## [v0.2.1] - 2022-03-04

### Fixed

* Use `NaiveDateTime.new/8` when decoding date to prevent confusing
  `%Inspect.Error{}` struct
* [`B5ZE`] Don't attempt to decode a date if the RTC clock integrity
  is not guaranteed

## [v0.2.0] - 2022-02-25

### Breaking Changes

* You must now explicitly choose which Abracon RTC model you wish to use
  in your `config.exs`
* Existing behavior in `NervesTime.RTC.Abracon` was moved to
  `NervesTime.RTC.Abracon.IBO5` and you will need to update your
  `config.exs`:

  ```elixir
  config :nerves_time, rtc: NervesTime.RTC.Abracon.IBO5
  ```

### Added

* AB-RTCMC-32.768kHz-B5ZE-S3 support with `NervesTime.RTC.Abracon.B5ZE`

## [v0.1.1] - 2020-03-15

### Fixed

* Improve error return when the RTC isn't found

## [v0.1.0] - 2020-03-15

Initial release

[v0.2.1]: https://github.com/nerves-time/nerves_time_rtc_abracon/releases/tag/v0.2.1
[v0.2.0]: https://github.com/nerves-time/nerves_time_rtc_abracon/releases/tag/v0.2.0
[v0.1.1]: https://github.com/nerves-time/nerves_time_rtc_abracon/releases/tag/v0.1.1
[v0.1.0]: https://github.com/nerves-time/nerves_time_rtc_abracon/releases/tag/v0.1.0
