defmodule NervesTime.RTC.Abracon.AB0805.DateTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.AB0805.Date

  test "decodes date" do
    assert Date.decode(<<0, 2, 3, 4, 5, 6, 7, 2>>) ==
             {:ok, ~N[2007-06-05 04:03:02]}
  end

  test "does not return invalid date" do
    assert Date.decode(<<2, 3, 0, 0, 0, 0, 153, 7>>) == {:error, :invalid_date}
  end

  test "does not attempt decode on invalid binary" do
    assert Date.decode(<<"wat">>) == {:error, :invalid}
  end

  test "encodes date" do
    assert Date.encode(~N[2007-06-05 04:03:02]) == {:ok, <<0, 2, 3, 4, 5, 6, 7, 2>>}

    assert Date.encode(~N[2019-10-04 00:07:18]) ==
             {:ok, <<0, 24, 7, 0, 4, 16, 25, 5>>}
  end

  test "non-21st century dates return errors when encoded" do
    assert Date.encode(~N[1970-01-01 00:00:11]) == {:error, :invalid_date}
  end
end
