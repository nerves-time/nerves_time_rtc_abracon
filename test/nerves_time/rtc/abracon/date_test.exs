defmodule NervesTime.RTC.Abracon.DateTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.Date

  test "decodes date" do
    assert Date.decode(<<1, 2, 3, 4, 5, 6, 7>>) ==
             {:ok, ~N[2007-06-05 04:03:02.01]}
  end

  test "encodes date" do
    assert Date.encode(~N[2007-06-05 04:03:02.01]) == <<1, 2, 3, 4, 5, 6, 7>>
  end
end
