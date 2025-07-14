defmodule MixMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias MixMon.Game
  alias MixMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        name: "Jonh",
        hp: 100,
        moves: %{
          move_avg: :punch,
          move_rnd: :kick,
          move_heal: :heal
        }
      }

      assert expected_response == MixMon.create_player("Jonh", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "when the game is started, return a message" do
      player = Player.create("Jonh", :kick, :punch, :heal)

      messages =
        capture_io(fn ->
          assert MixMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.create("Jonh", :kick, :punch, :heal)

      capture_io(fn ->
        MixMon.start_game(player)
      end)

      {:ok, player: player}
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          assert MixMon.make_move(:kick)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn!"
      assert messages =~ "It's player turn!"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, return an error message" do
      messages =
        capture_io(fn ->
          assert MixMon.make_move(:invalid_move)
        end)

      assert messages =~ "Invalid move: invalid_move"
    end
  end
end
