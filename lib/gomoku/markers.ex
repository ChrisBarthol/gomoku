defmodule Gomoku.Markers do
	alias __MODULE__

	@enforce_keys [:black, :white]
	defstruct [:black, :white]

	def new(), do:
		%Markers{black: MapSet.new(), white: MapSet.new()}

	def add(%Markers{} = markers, :black, %Coordinate{} = coordinate), do:
		update_in(markers.black, &MapSet.put(&1, coordinate))

	def add(%Markers{} = markers, :white, %Coordinate{} = coordinate), do:
		update_in(markers.white, &MapSet.put(&1, coordinate))

	def overlaps?(coordinate, new_marker), do:
		not MapSet.disjoint?(coordinate, new_marker)

end
