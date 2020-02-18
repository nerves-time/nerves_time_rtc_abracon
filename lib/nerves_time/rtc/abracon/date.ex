defmodule NervesTime.RTC.Abracon.Date do
  @moduledoc false

  alias NervesTime.RealTimeClock.BCD

  @doc """
  Return a list of commands for reading the configuration registers
  """
  def reads() do
    # Register 0x00 to 0x06
    [{:write_read, <<0x0>>, 7}]
  end

  @spec decode(<<_::56>>) :: {:ok, NaiveDateTime.t()} | {:error, any()}
  def decode(
        <<hundredths_bcd, seconds_bcd, minutes_bcd, hours24_bcd, day_bcd, month_bcd, year_bcd>>
      ) do
    {:ok,
     %NaiveDateTime{
       microsecond: {BCD.to_integer(hundredths_bcd) * 10000, 2},
       second: BCD.to_integer(seconds_bcd),
       minute: BCD.to_integer(minutes_bcd),
       hour: BCD.to_integer(hours24_bcd),
       day: BCD.to_integer(day_bcd),
       month: BCD.to_integer(month_bcd),
       year: 2000 + BCD.to_integer(year_bcd)
     }}
  end

  def decode(_other), do: {:error, :invalid}

  @spec encode(NaiveDateTime.t()) :: <<_::56>>
  def encode(%NaiveDateTime{} = date_time) do
    {microseconds, _precision} = date_time.microsecond
    hundredths_bcd = BCD.from_integer(div(microseconds, 10000))
    seconds_bcd = BCD.from_integer(date_time.second)
    minutes_bcd = BCD.from_integer(date_time.minute)
    hours24_bcd = BCD.from_integer(date_time.hour)
    day_bcd = BCD.from_integer(date_time.day)
    month_bcd = BCD.from_integer(date_time.month)
    year_bcd = BCD.from_integer(date_time.year - 2000)

    <<
      hundredths_bcd,
      seconds_bcd,
      minutes_bcd,
      hours24_bcd,
      day_bcd,
      month_bcd,
      year_bcd
    >>
  end
end
