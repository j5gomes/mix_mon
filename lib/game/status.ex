defmodule MixMon.Game.Status do
  alias MixMon.Game

  def print_round_message do
    IO.puts("\n===== The game has started! =====\n")
    IO.inspect(Game.info())
    IO.puts("-----------------")
  end
end
