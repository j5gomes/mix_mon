defmodule MixMon.Game.Actions.Attack do
  alias MixMon.Game

  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:hp)
    |> calculate_total_hp(damage)
    |> update_opponent_hp(opponent)
  end

  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)

  defp calculate_total_hp(hp, damage) when hp - damage < 0, do: 0
  defp calculate_total_hp(hp, damage), do: hp - damage

  defp update_opponent_hp(hp, opponent) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:hp, hp)
  end
end
