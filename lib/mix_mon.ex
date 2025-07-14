defmodule MixMon do
  alias MixMon.{Game, Player}
  alias MixMon.Game.{Actions, Status}

  @computer_name "Mr. Robot"

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.create(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end

  def make_move(move) do
    Actions.fetch_move(move)
  end
end
