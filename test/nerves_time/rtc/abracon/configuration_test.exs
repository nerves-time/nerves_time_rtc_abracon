defmodule NervesTime.RTC.Abracon.ConfigurationTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.Configuration

  test "decodes configuration" do
    assert Configuration.decode(<<19, 60>>) ==
             {:ok,
              %{
                arst: 0,
                clk_int: 0,
                clkb: 1,
                psw: 7,
                pswb: 0,
                pswc: 1,
                rstp: 0,
                stop: 0,
                twelve_hour: 0,
                wrtc: 1
              }}
  end
end
