defmodule NervesTime.RTC.Abracon.AB0805.Date do
  @moduledoc false

  alias NervesTime.RealTimeClock.BCD

  @doc """
  Return a list of commands for reading the configuration registers
  """
  def reads() do
    # Register 0x00 to 0x07
    [{:write_read, <<0x00>>, 8}]
  end

  @doc """
  Decode register values into a date

  This only returns years between 2000 and 2099.
  """
  @spec decode(<<_::64>>) :: {:ok, NaiveDateTime.t()} | {:error, any()}

  def decode(
        <<_hunredths, _gp0::1, seconds_bcd::7, _gp1::1, minutes_bcd::7, _gp3::1, _gp2::1,
          _ampm::1, hours24_bcd::5, _gp5::1, _gp4::1, day_bcd::6, _gp8::1, _gp7::1, _gp6::1,
          month_bcd::5, year_bcd, _gp13::1, _gp12::1, _gp11::1, _gp10::1, _gp9::1, _week_bcd::3>>
      ) do
    NaiveDateTime.new(
      2000 + BCD.to_integer(year_bcd),
      BCD.to_integer(month_bcd),
      BCD.to_integer(day_bcd),
      BCD.to_integer(hours24_bcd),
      BCD.to_integer(minutes_bcd),
      BCD.to_integer(seconds_bcd)
    )
  end

  def decode(_other), do: {:error, :invalid}

  @doc """
  Encode the specified date to register values.

  Only dates between 2001 and 2099 are supported. This avoids the need to deal
  with the leap year special case for 2000. That would involve setting the
  century bit and that seems like a pointless complexity for a date that has come and gone.
  """
  @spec encode(NaiveDateTime.t()) :: {:ok, <<_::64>>} | {:error, any()}
  def encode(%NaiveDateTime{year: year} = date_time) when year > 2000 and year < 2100 do
    seconds_bcd = BCD.from_integer(date_time.second)
    minutes_bcd = BCD.from_integer(date_time.minute)
    hours24_bcd = BCD.from_integer(date_time.hour)
    day_bcd = BCD.from_integer(date_time.day)
    month_bcd = BCD.from_integer(date_time.month)
    year_bcd = BCD.from_integer(year - 2000)
    weekday_bcd = Date.day_of_week(date_time) |> BCD.from_integer()

    {:ok,
     <<0, 0::1, seconds_bcd::7, 0::1, minutes_bcd::7, 0::1, 0::1, 0::1, hours24_bcd::5, 0::1,
       0::1, day_bcd::6, 0::1, 0::1, 0::1, month_bcd::5, year_bcd, 0::1, 0::1, 0::1, 0::1, 0::1,
       weekday_bcd::3>>}
  end

  def encode(_invalid_date) do
    {:error, :invalid_date}
  end
end
