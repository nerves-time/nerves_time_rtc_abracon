defmodule NervesTime.RTC.Abracon.AB0805.ConfigurationTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.AB0805.Configuration

  test "decodes configuration" do
    assert Configuration.decode(<<17, 0>>) ==
             {:ok,
              %{
                arst: 0,
                out: 1,
                out1s: 0,
                out2s: 0,
                outb: 0,
                stop: 0,
                twelve_hour: 0,
                wrtc: 1
              }}
  end
end
