defmodule NervesTime.RTC.Abracon.B5ZE.Date do
  @moduledoc false

  alias NervesTime.RealTimeClock.BCD

  @doc """
  Return a list of commands for reading the configuration registers
  """
  def reads() do
    # Register 0x03 to 0x09
    [{:write_read, <<0x03>>, 7}]
  end

  @doc """
  Decode register values into a date

  This only returns years between 2000 and 2099.
  """
  @spec decode(<<_::56>>) :: {:ok, NaiveDateTime.t()} | {:error, any()}
  def decode(<<seconds_bcd, minutes_bcd, hours24_bcd, day_bcd, _weekday, month_bcd, year_bcd>>) do
    {:ok,
     %NaiveDateTime{
       second: BCD.to_integer(seconds_bcd),
       minute: BCD.to_integer(minutes_bcd),
       hour: BCD.to_integer(hours24_bcd),
       day: BCD.to_integer(day_bcd),
       month: BCD.to_integer(month_bcd),
       year: 2000 + BCD.to_integer(year_bcd)
     }}
  end

  def decode(_other), do: {:error, :invalid}

  @doc """
  Encode the specified date to register values.

  Only dates between 2001 and 2099 are supported. This avoids the need to deal
  with the leap year special case for 2000. That would involve setting the
  century bit and that seems like a pointless complexity for a date that has come and gone.
  """
  @spec encode(NaiveDateTime.t()) :: {:ok, <<_::56>>} | {:error, any()}
  def encode(%NaiveDateTime{year: year} = date_time) when year > 2000 and year < 2100 do
    seconds_bcd = BCD.from_integer(date_time.second)
    minutes_bcd = BCD.from_integer(date_time.minute)
    hours24_bcd = BCD.from_integer(date_time.hour)
    day_bcd = BCD.from_integer(date_time.day)
    month_bcd = BCD.from_integer(date_time.month)
    year_bcd = BCD.from_integer(year - 2000)
    weekday_bcd = Date.day_of_week(date_time) |> BCD.from_integer()

    {:ok,
     <<
       seconds_bcd,
       minutes_bcd,
       hours24_bcd,
       day_bcd,
       weekday_bcd,
       month_bcd,
       year_bcd
     >>}
  end

  def encode(_invalid_date) do
    {:error, :invalid_date}
  end
end
