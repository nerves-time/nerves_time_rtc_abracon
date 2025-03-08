# SPDX-FileCopyrightText: 2020 Frank Hunleth
# SPDX-FileCopyrightText: 2022 Jon Carstens
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule NervesTime.RTC.Abracon.IBO5.ConfigurationTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.IBO5.Configuration

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
