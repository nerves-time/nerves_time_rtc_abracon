defmodule NervesTime.RTC.Abracon.IBO5.DateTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.IBO5.Date

  test "decodes date" do
    assert Date.decode(<<1, 2, 3, 4, 5, 6, 7>>) ==
             {:ok, ~N[2007-06-05 04:03:02.01]}
  end

  test "does not return invalid date" do
    assert Date.decode(<<1, 2, 0, 0, 0, 0, 7>>) == {:error, :invalid_date}
  end

  test "does not attempt decode on invalid binary" do
    assert Date.decode(<<"wat">>) == {:error, :invalid}
  end

  test "encodes date" do
    assert Date.encode(~N[2007-06-05 04:03:02.01]) == {:ok, <<1, 2, 3, 4, 5, 6, 7>>}

    assert Date.encode(~N[2019-10-04 00:07:18.865722]) ==
             {:ok, <<0x86, 0x18, 0x07, 0x00, 0x04, 0x10, 0x19>>}
  end

  test "non-21st century dates return errors when encoded" do
    assert Date.encode(~N[1970-01-01 00:00:11.809623]) == {:error, :invalid_date}
  end
end
