defmodule MixMon.GameTest do
  alias MixMon.Game
  alias MixMon.Player
  use ExUnit.Case

  describe "start/2" do
    test "starts the game state" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          name: "Jonh",
          hp: 100,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        },
        computer: %Player{
          name: "Computer",
          hp: 100,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "return the game state updated" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          name: "Jonh",
          hp: 100,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        },
        computer: %Player{
          name: "Computer",
          hp: 100,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        },
        turn: :player
      }

      assert expected_response == Game.info()

      new_game_state = %{
        turn: :player,
        status: :continue,
        player: %Player{
          name: "Jonh",
          hp: 78,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        },
        computer: %Player{
          name: "Computer",
          hp: 12,
          moves: %{
            move_avg: :kick,
            move_rnd: :punch,
            move_heal: :heal
          }
        }
      }

      Game.update(new_game_state)

      expected_response = %{new_game_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the game player" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response =
        Game.info()
        |> Map.get(:player)

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the game turn" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response =
        Game.info()
        |> Map.get(:turn)

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player info" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response =
        Game.info()
        |> Map.get(:player)

      assert expected_response == Game.fetch_player(:player)
    end

    test "returns the computer info" do
      player = Player.create("Jonh", :kick, :punch, :heal)
      computer = Player.create("Computer", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response =
        Game.info()
        |> Map.get(:computer)

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end
