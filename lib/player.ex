defmodule MixMon.Player do
  @player_attibutes [
    :hp,
    :moves,
    :name
  ]
  @max_hp 100

  @enforce_keys @player_attibutes
  defstruct @player_attibutes

  def create(name, move_rnd, move_avg, move_heal) do
    %MixMon.Player{
      hp: @max_hp,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name
    }
  end
end
