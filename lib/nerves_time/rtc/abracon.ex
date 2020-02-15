defmodule NervesTime.RTC.Abracon do
  @moduledoc """
  See https://abracon.com/Support/AppsManuals/Precisiontiming/Application%20Manual%20AB-RTCMC-32.768kHz-IBO5-S3.pdf


  """

  @behaviour NervesTime.RealTimeClock

  require Logger

  alias Circuits.I2C
  alias NervesTime.RTC.Abracon.{Date, ID}

  @default_bus_name "i2c-1"
  @default_address 0x69

  @typedoc false
  @type state :: %{
          i2c: I2C.bus(),
          bus_name: String.t(),
          address: I2C.address()
        }

  @doc false
  @impl NervesTime.RealTimeClock
  def init(args) do
    bus_name = Keyword.get(args, :bus_name, @default_bus_name)
    address = Keyword.get(args, :address, @default_address)

    with {:ok, i2c} <- I2C.open(bus_name),
         true <- rtc_available?(i2c, address) do
      {:ok, %{i2c: i2c, bus_name: bus_name, address: address}}
    else
      {:error, _} = error ->
        error

      error ->
        {:error, error}
    end
  end

  @impl NervesTime.RealTimeClock
  def update(state) do
    set_time_to_rtc(state, NaiveDateTime.utc_now())
  end

  @impl NervesTime.RealTimeClock
  def time(state) do
    get_time_from_rtc(state)
  end

  @spec set_time_to_rtc(state, NaiveDateTime.t()) :: :ok | {:error, term()}
  defp set_time_to_rtc(state, %NaiveDateTime{} = date_time) do
    registers = Date.encode(date_time)

    I2C.write(state.i2c, state.address, [0, registers])
  end

  @spec get_time_from_rtc(state) :: {:ok, NaiveDateTime.t()} | {:error, term()}
  defp get_time_from_rtc(state) do
    with {:ok, registers} <-
           I2C.write_read(state.i2c, state.address, <<0>>, 7) do
      Date.decode(registers)
    end
  end

  @spec rtc_available?(I2C.bus(), I2C.address()) :: boolean()
  defp rtc_available?(i2c, address) do
    case I2C.write_read(i2c, address, <<0x28>>, 7) do
      {:ok, id_info} ->
        supported?(ID.decode(id_info))

      {:error, :i2c_nak} ->
        false
    end
  end

  defp supported?({:ok, %{id: :ab_rtcmc_32768khz_ibo5_s3}}), do: true
  defp supported?(_other), do: false
end
