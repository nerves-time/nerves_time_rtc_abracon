# SPDX-FileCopyrightText: 2022 Connor Rigby
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule NervesTime.RTC.Abracon.AB0805.Configuration do
  @type bit() :: 0 | 1
  @type t :: %{
          stop: bit(),
          twelve_hour: bit(),
          outb: bit(),
          out: bit(),
          arst: bit(),
          wrtc: bit(),
          out2s: 0..7,
          out1s: 0..3
        }

  @spec decode(<<_::16>>) :: {:ok, t()} | {:error, any()}
  def decode(
        <<stop::1, twelve_hour::1, outb::1, out::1, _::1, arst::1, _::1, wrtc::1, _::3, out2s::3,
          out1s::2>>
      ) do
    config = %{
      stop: stop,
      twelve_hour: twelve_hour,
      outb: outb,
      out: out,
      arst: arst,
      wrtc: wrtc,
      out2s: out2s,
      out1s: out1s
    }

    {:ok, config}
  end

  def decode(_other), do: {:error, :invalid}

  @spec encode(t()) :: <<_::16>>
  def encode(cfg) do
    <<
      cfg.stop::1,
      cfg.twelve_hour::1,
      cfg.outb::1,
      cfg.out::1,
      0::1,
      cfg.arst::1,
      0::1,
      cfg.wrtc::1,
      0::3,
      cfg.out2s::3,
      cfg.out1s::2
    >>
  end
end
