defmodule MixMon.Game.Actions.Heal do
  alias MixMon.Game
  alias MixMon.Game.Status

  @heal_power 18..25

  def heal_hp(player) do
    player
    |> Game.fetch_player()
    |> Map.get(:hp)
    |> calculate_total_hp()
    |> set_hp(player)
  end

  defp calculate_total_hp(hp), do: Enum.random(@heal_power) + hp

  defp set_hp(hp, player) when hp > 100, do: update_player_hp(player, 100)
  defp set_hp(hp, player), do: update_player_hp(player, hp)

  defp update_player_hp(player, hp) do
    player
    |> Game.fetch_player()
    |> Map.put(:hp, hp)
    |> update_game(player, hp)
  end

  defp update_game(player_data, player, hp) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()

    Status.print_move_message(player, :heal, hp)
  end
end
