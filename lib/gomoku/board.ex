defmodule Gomoku.Board do
	alias Gomoku.{Coordinate, Markers}
	def new(), do: %{}

	def mark(board, %Coordinate{} = coordinate) do
		board
		|> check_markers(coordinate)
		|> guess_response(board)
	end

	def check_markers(board, key, %Markers{} = marker) do
		case overlaps_exisiting_marker?(board, key, marker) do
			true -> {:error, :overlapping_marker}
			false -> {key, marker}
		end
	end

	defp overlaps_exisiting_marker?(board, new_key, new_marker) do
		Enum.any?(board, fn {key, marker} ->
			key != new_key and Markers.overlaps?(marker, new_marker)
		end)
	end

	defp guess_response({key, marker}, board) do
		board =%{board | key => marker}
		{:fill, win_check(board), board}
	end

	defp win_check(board) do
		board
		|> row_check(board)
		|> column_check(board)
		|> forward_dia_check(board)
		|> reverse_dia_check(board)
	end

	defp row_check(board) do
		true
	end

	defp column_check(board) do
		true
	end

	defp forward_dia_check(board) do
		true
	end

	defp reverse_dia_check(board) do
		true
	end
	# def check_markers(board, coordinate) do
	# 	Enum.find_value(board, :empty, fn {key, island} ->
	# 		case Marker.guess(marker, coordinate) do
	# 			{:empty, marker} -> {key, marker}
	# 			:full					   -> false
	# 		end
	# 	end)
	# end
end
