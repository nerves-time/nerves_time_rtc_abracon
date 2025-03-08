# SPDX-FileCopyrightText: 2022 Connor Rigby
# SPDX-FileCopyrightText: 2023 Masatoshi Nishiguchi
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule NervesTime.RTC.Abracon.AB0805 do
  @moduledoc """
  Abracon AB0805-T3 RTC implementation for NervesTime

  To configure NervesTime to use this module, update the `:nerves_time` application
  environment like this:

  ```elixir
  config :nerves_time, rtc: NervesTime.RTC.Abracon.AB0805
  ```

  If not using `"i2c-1"` or the default I2C bus address, specify them like this:

  ```elixir
  config :nerves_time, rtc: {NervesTime.RTC.Abracon.AB0805, [bus_name: "i2c-2", address: 0x69]}
  ```

  Check the logs for error messages if the RTC doesn't appear to work.

  See https://abracon.com/realtimeclock/ab08xx-appl-manual.html.pdf
  for implementation details.
  """

  @behaviour NervesTime.RealTimeClock

  require Logger

  alias Circuits.I2C
  alias NervesTime.RTC.Abracon.AB0805.{Configuration, Date}

  @default_bus_name "i2c-1"
  @default_address 0x69

  @typedoc false
  @type state :: %{
          i2c: I2C.Bus.t(),
          bus_name: String.t(),
          address: I2C.address(),
          config: Configuration.t()
        }

  @impl NervesTime.RealTimeClock
  def init(args) do
    bus_name = Keyword.get(args, :bus_name, @default_bus_name)
    address = Keyword.get(args, :address, @default_address)

    with {:ok, i2c} <- I2C.open(bus_name),
         {:ok, config} <- probe(i2c, address) do
      {:ok, %{i2c: i2c, bus_name: bus_name, address: address, config: config}}
    end
  end

  @impl NervesTime.RealTimeClock
  def terminate(_state), do: :ok

  @impl NervesTime.RealTimeClock
  def set_time(state, now) do
    with {:ok, registers} <- Date.encode(now),
         :ok <- I2C.write(state.i2c, state.address, [0, registers]) do
      state
    else
      error ->
        _ = Logger.error("Error setting Abracon RTC to #{inspect(now)}: #{inspect(error)}")
        state
    end
  end

  @impl NervesTime.RealTimeClock
  def get_time(state) do
    with {:ok, registers} <- I2C.write_read(state.i2c, state.address, <<0>>, 8),
         {:ok, time} <- Date.decode(registers) do
      {:ok, time, state}
    else
      any_error ->
        _ = Logger.error("Abracon RTC not set or has an error: #{inspect(any_error)}")
        {:unset, state}
    end
  end

  defp probe(i2c, address) do
    case I2C.write_read(i2c, address, <<0x10>>, 2) do
      {:ok, cfg_info} ->
        Configuration.decode(cfg_info)

      {:error, :i2c_nak} ->
        {:error, "RTC not found at #{address}"}
    end
  end
end
