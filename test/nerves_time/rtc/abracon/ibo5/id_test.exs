defmodule NervesTime.RTC.Abracon.IBO5.IDTest do
  use ExUnit.Case
  alias NervesTime.RTC.Abracon.IBO5.ID

  test "decodes ID" do
    assert ID.decode(<<24, 5, 19, 49, 70, 89, 48>>) ==
             {:ok, %{id: :ab_rtcmc_32768khz_ibo5_s3, lot: 49, part_id: 18009, wafer: 12}}
  end
end
