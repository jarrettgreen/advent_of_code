defmodule Day1 do
  def main(instructions) do
    compass = {:n, :e, :s, :w}
    coordinates = %{x: 0, y: 0}
    instructions = ["L1","L5","R1","R3","L4","L5","R5","R1","L2","L2","L3","R4","L2","R3","R1","L2","R5","R3","L4","R4","L3","R3","R3","L2","R1","L3","R2","L1","R4","L2","R4","L4","R5","L3","R1","R1","L1","L3","L2","R1","R3","R2","L1","R4","L4","R2","L189","L4","R5","R3","L1","R47","R4","R1","R3","L3","L3","L2","R70","L1","R4","R185","R5","L4","L5","R4","L1","L4","R5","L3","R2","R3","L5","L3","R5","L1","R5","L4","R1","R2","L2","L5","L2","R4","L3","R5","R1","L5","L4","L3","R4","L3","L4","L1","L5","L5","R5","L5","L2","L1","L2","L4","L1","L2","R3","R1","R1","L2","L5","R2","L3","L5","L4","L2","L1","L2","R3","L1","L4","R3","R3","L2","R5","L1","L3","L3","L3","L5","R5","R1","R2","L3","L2","R4","R1","R1","R3","R4","R3","L3","R3","L5","R2","L2","R4","R5","L4","L3","L1","L5","L1","R1","R2","L1","R3","R4","R5","R2","R3","L2","L1","L5"]
  end



  def navigate(compass, coordinates, instructions) do
    for step <- instructions do
      {direction, distance} = step
      compass = turn(compass, direction)
      move(compass, coordinates, distance)
    end

  end


  @doc """
    Turns the directions into a list of tuples

    ## Examples:
      iex> directions = ["R2", "L3"]
      iex> Day1.assemble_directions(directions)
      [{"R", 2}, {"L",3}]
  """

  def assemble_directions(directions) do
    working_directions = Enum.map directions, fn(direction_set) ->
      [direction, distance] = String.split(direction_set, ~r{}, trim: true)
      {direction, String.to_integer(distance)}
    end
  end


  @doc """
    Turns in the right cardinal direction

    ## Examples:
      iex> compass = {:n, :e, :s, :w}
      iex> Day1.turn(compass, "L")
      {:w, :n, :e, :s}
  """


  def turn(compass, direction) do
    case direction do
      "L" -> turn_left(compass)
      "R" -> turn_right(compass)
    end
  end

  @doc """
    Shifts the compass to the right.

    ## Examples:
      iex> compass = {:n, :e, :s, :w}
      iex> Day1.turn_right(compass)
      {:e, :s, :w, :n}
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
      iex> compass = {:n, :e, :s, :w}
      iex> Day1.turn_left(compass)
      {:w, :n, :e, :s}
  """
  def turn_left(compass) do
    { _, _, _, last } = compass
    new_compass = compass
      |> Tuple.delete_at(3)
      |> Tuple.insert_at(0,last)
    new_compass
  end

  @doc """
    Increments coordinates positively for North and East, and Negatively for West and South

    ## Examples:
      iex> compass = {:n, :e, :s, :w}
      iex> coordinates = %{x: 0, y: 0}
      iex> distance = 5
      iex> Day1.move(compass, coordinates, distance)
      %{x: 0, y: 5}
  """

  def move(compass, coordinates, distance) do
    new_coordinates = case compass do
      {:n,_ ,_ ,_ } -> Map.update!(coordinates, :y, &(&1 + distance))
      {:e,_ ,_ ,_ } -> Map.update!(coordinates, :x, &(&1 + distance))
      {:s,_ ,_ ,_ } -> Map.update!(coordinates, :y, &(&1 - distance))
      {:w,_ ,_ ,_ } -> Map.update!(coordinates, :x, &(&1 - distance))
    end



  end
end
