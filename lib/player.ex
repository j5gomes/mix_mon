defmodule MixMon.Player do
  @enforce_keys [:hp, :name, :move_rnd, :move_avg, :move_heal]

  defstruct [:hp, :name, :move_rnd, :move_avg, :move_heal]

  def build(name, move_rnd, move_avg, move_heal) do
    %MixMon.Player{
      hp: 100,
      name: name,
      move_rnd: move_rnd,
      move_avg: move_avg,
      move_heal: move_heal
    }
  end
end
