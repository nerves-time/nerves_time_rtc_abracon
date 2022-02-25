defmodule NervesTime.RTC.Abracon.B5ZE.Configuration do
  @type bit() :: 0 | 1
  @type t :: %{
          stop: bit(),
          sr: bit(),
          twelve_hour: bit(),
          sie: bit(),
          aie: bit(),
          cie: bit(),
          wtaf: bit(),
          ctaf: bit(),
          ctbf: bit(),
          sf: bit(),
          af: bit(),
          wtaie: bit(),
          ctaie: bit(),
          ctbie: bit(),
          battery: 0..7,
          bsf: bit(),
          blf: bit(),
          bsei: bit(),
          blie: bit()
        }

  @spec decode(<<_::24>>) :: {:ok, t()} | {:error, any()}
  def decode(
        <<0::1, 0::1, stop::1, sr::1, twelve_hour::1, sie::1, aie::1, cie::1, wtaf::1, ctaf::1,
          ctbf::1, sf::1, af::1, wtaie::1, ctaie::1, ctbie::1, battery::3, _unused::1, bsf::1,
          blf::1, bsei::1, blie::1>>
      ) do
    config = %{
      stop: stop,
      sr: sr,
      twelve_hour: twelve_hour,
      sie: sie,
      aie: aie,
      cie: cie,
      wtaf: wtaf,
      ctaf: ctaf,
      ctbf: ctbf,
      sf: sf,
      af: af,
      wtaie: wtaie,
      ctaie: ctaie,
      ctbie: ctbie,
      battery: battery,
      bsf: bsf,
      blf: blf,
      bsei: bsei,
      blie: blie
    }

    {:ok, config}
  end

  def decode(_other), do: {:error, :invalid}

  @spec encode(t()) :: <<_::24>>
  def encode(cfg) do
    <<0::1, 0::1, cfg.stop::1, cfg.sr::1, cfg.twelve_hour::1, cfg.sie::1, cfg.aie::1, cfg.cie::1,
      cfg.wtaf::1, cfg.ctaf::1, cfg.ctbf::1, cfg.sf::1, cfg.af::1, cfg.wtaie::1, cfg.ctaie::1,
      cfg.ctaie::1, cfg.battery::3, 0::1, cfg.bsf::1, cfg.blf::1, cfg.bsei::1, cfg.blie::1>>
  end
end
