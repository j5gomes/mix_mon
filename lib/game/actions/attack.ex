defmodule MixMon.Game.Actions.Attack do
  alias MixMon.Game
  alias MixMon.Game.Status

  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:hp)
    |> calculate_total_hp(damage)
    |> update_opponent_hp(opponent, damage)
  end

  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)

  defp calculate_total_hp(hp, damage) when hp - damage < 0, do: 0
  defp calculate_total_hp(hp, damage), do: hp - damage

  defp update_opponent_hp(hp, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:hp, hp)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
