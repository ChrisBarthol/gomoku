defmodule Gomoku.Rules do
	alias __MODULE__

	defstruct state: :initalized,
						player1: :not_ready,
						player2: :not_ready

	def new(), do: %Rules{}

	def check(_state, _action), do: :error

	def check(%Rules{state: :initialized} = rules, :add_player), do:
		{:ok, %Rules{rules | state: :players_ready}}

	def check(%Rules{state: :players_ready} = rules, {:get_ready, player }) do
		rules = Map.put(rules, player, :players_ready)
		case both_players_ready?(rules) do
			true -> {:ok, %Rules{rules | state: :player1_turn}}
			false -> {:ok, rules}
		end
	end

	def check(%Rules{state: :player1_turn} = rules, {:mark, :player1}), do:
		{:ok, %Rules{rules | state: :player2_turn}}

	def check(%Rules{state: :player1_turn} = rules, {:win_check, win_or_not}) do
		case win_or_not do
			:no_win -> {:ok, rules}
			:win -> {:ok, %Rules{rules | state: :game_over}}
		end
	end

	def check(%Rules{state: :player2_turn} = rules, {:mark, :player2}), do:
		{:ok, %Rules{rules | state: :player2_turn}}

	def check(%Rules{state: :player2_turn} = rules, {:win_check, win_or_not}) do
		case win_or_not do
			:no_win -> {:ok, rules}
			:win -> {:ok, %Rules{rules | state: :game_over}}
		end
	end

	defp both_players_ready?(rules), do:
		rules.player1 == :players_ready && rules.player2 == :players_ready
end
