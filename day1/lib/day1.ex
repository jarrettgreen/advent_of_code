defmodule Day1 do
  def main() do
    compass = {'N', 'E', 'S', 'W'}
    directions = [L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5]
    directions
  end

  def turn(compass, direction) do

  end


  @doc """
    Turns the directions into a list of tuples

    ## Examples:
      iex> directions = ["R2", "L3"]
      iex> Day1.assemble_directions(directions)
      [{"R", "2"}, {"L","3"}]
  """

  def assemble_directions(directions) do
    working_directions = Enum.map directions, fn(direction_set) ->
      [direction, paces] = String.split(direction_set, ~r{}, trim: true)
      {direction, paces}
    end
  end

  @doc """
    Shifts the compass to the right.

    ## Examples:
      iex> compass = {'N', 'E', 'S', 'W'}
      iex> Day1.turn_right(compass)
      {'E', 'S', 'W', 'N'}
  """
  def turn_right(compass) do
    {first,_ ,_ ,_ } = compass
    new_compass = compass
      |> Tuple.delete_at(0)
      |> Tuple.append(first)
    new_compass
  end


  @doc """
    Shifts the compass to the left.

    ## Examples:
      iex> compass = {'N', 'E', 'S', 'W'}
      iex> Day1.turn_left(compass)
      {'W', 'N', 'E', 'S'}
  """
  def turn_left(compass) do
    { _, _, _, last } = compass
    new_compass = compass
      |> Tuple.delete_at(3)
      |> Tuple.insert_at(0,last)
    new_compass
  end



  def walk(distance) do

  end
end
