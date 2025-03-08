# SPDX-FileCopyrightText: 2022 Jon Carstens
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule NervesTime.RTC.Abracon.B5ZE.DateTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.B5ZE.Date

  test "decodes date" do
    assert Date.decode(<<2, 3, 4, 5, 2, 6, 7>>) ==
             {:ok, ~N[2007-06-05 04:03:02]}
  end

  test "does not return invalid date" do
    assert Date.decode(<<2, 3, 0, 0, 0, 153, 7>>) == {:error, :invalid_date}
  end

  test "does not attempt decode on invalid binary" do
    assert Date.decode(<<"wat">>) == {:error, :invalid}
  end

  test "does not decode date if clock integrity is not guaranteed" do
    assert Date.decode(<<160, 3, 4, 5, 2, 6, 7>>) == {:error, :clock_integrity_not_guaranteed}
  end

  test "encodes date" do
    assert Date.encode(~N[2007-06-05 04:03:02]) == {:ok, <<2, 3, 4, 5, 2, 6, 7>>}

    assert Date.encode(~N[2019-10-04 00:07:18]) ==
             {:ok, <<0x18, 0x07, 0x00, 0x04, 0x05, 0x10, 0x19>>}
  end

  test "non-21st century dates return errors when encoded" do
    assert Date.encode(~N[1970-01-01 00:00:11]) == {:error, :invalid_date}
  end
end
