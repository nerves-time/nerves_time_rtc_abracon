defmodule NervesTime.RTC.Abracon.Configuration do
  @moduledoc false

  @type bit() :: 0 | 1

  @type t() :: %{
          arst: bit(),
          clk_int: 0..3,
          clkb: bit(),
          psw: 0..7,
          pswb: bit(),
          pswc: bit(),
          rstp: bit(),
          stop: bit(),
          twelve_hour: bit(),
          wrtc: bit()
        }

  @doc """
  Return a list of commands for reading the configuration registers
  """
  def reads() do
    # Register 0x10, and 0x11
    [{:write_read, <<0x10>>, 2}]
  end

  @spec decode(<<_::16>>) :: {:ok, t()} | {:error, any()}
  def decode(
        <<stop::integer-1, twelve_hour::integer-1, pswb::integer-1, clkb::integer-1,
          rstp::integer-1, arst::integer-1, pswc::integer-1, wrtc::integer-1,
          _reserved::integer-3, psw::integer-3, clk_int::integer-2>>
      ) do
    {:ok,
     %{
       stop: stop,
       twelve_hour: twelve_hour,
       pswb: pswb,
       clkb: clkb,
       rstp: rstp,
       arst: arst,
       pswc: pswc,
       wrtc: wrtc,
       psw: psw,
       clk_int: clk_int
     }}
  end

  def decode(_other), do: {:error, :invalid}

  @spec encode(t()) :: <<_::16>>
  def encode(%{
        stop: stop,
        twelve_hour: twelve_hour,
        pswb: pswb,
        clkb: clkb,
        rstp: rstp,
        arst: arst,
        pswc: pswc,
        wrtc: wrtc,
        psw: psw,
        clk_int: clk_int
      }) do
    <<stop::integer-1, twelve_hour::integer-1, pswb::integer-1, clkb::integer-1, rstp::integer-1,
      arst::integer-1, pswc::integer-1, wrtc::integer-1, 0::integer-3, psw::integer-3,
      clk_int::integer-2>>
  end
end
