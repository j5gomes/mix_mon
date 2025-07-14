defmodule MixMon do
  alias MixMon.Player

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.create(name, move_rnd, move_avg, move_heal)
  end
end
