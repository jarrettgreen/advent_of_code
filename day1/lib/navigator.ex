defmodule Day1.Navigator do
  defstruct compass: {:n, :e, :s, :w}, coordinates: %{x: 0, y: 0}, instructions: nil
end
