# SPDX-FileCopyrightText: 2022 Jon Carstens
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule NervesTime.RTC.Abracon.B5ZE.ConfigurationTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.B5ZE.Configuration

  test "decodes configuration" do
    assert Configuration.decode(<<0, 0, 4>>) ==
             {:ok,
              %{
                af: 0,
                aie: 0,
                battery: 0,
                blf: 1,
                blie: 0,
                bsei: 0,
                bsf: 0,
                cie: 0,
                ctaf: 0,
                ctaie: 0,
                ctbie: 0,
                ctbf: 0,
                sf: 0,
                sie: 0,
                sr: 0,
                stop: 0,
                twelve_hour: 0,
                wtaf: 0,
                wtaie: 0
              }}
  end
end
