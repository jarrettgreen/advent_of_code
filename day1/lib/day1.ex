

defmodule Day1 do
  def main() do
    # instructions = ["L1","L5","R1","R3","L4","L5","R5","R1","L2","L2","L3","R4","L2","R3","R1","L2","R5","R3","L4","R4","L3","R3","R3","L2","R1","L3","R2","L1","R4","L2","R4","L4","R5","L3","R1","R1","L1","L3","L2","R1","R3","R2","L1","R4","L4","R2","L189","L4","R5","R3","L1","R47","R4","R1","R3","L3","L3","L2","R70","L1","R4","R185","R5","L4","L5","R4","L1","L4","R5","L3","R2","R3","L5","L3","R5","L1","R5","L4","R1","R2","L2","L5","L2","R4","L3","R5","R1","L5","L4","L3","R4","L3","L4","L1","L5","L5","R5","L5","L2","L1","L2","L4","L1","L2","R3","R1","R1","L2","L5","R2","L3","L5","L4","L2","L1","L2","R3","L1","L4","R3","R3","L2","R5","L1","L3","L3","L3","L5","R5","R1","R2","L3","L2","R4","R1","R1","R3","R4","R3","L3","R3","L5","R2","L2","R4","R5","L4","L3","L1","L5","L1","R1","R2","L1","R3","R4","R5","R2","R3","L2","L1","L5"]
    instructions = ["R5", "L5", "R5", "R3"]
    instructions
    |> assemble_directions
    |> navigate
    # |> report
  end

  @doc """
    Turns the directions into a list of tuples, and gives them to the Navigator

    ## Examples:
      iex> directions = ["R2", "L3"]
      iex> Day1.assemble_directions(directions)
      %Day1.Navigator{compass: {:n, :e, :s, :w},coordinates: %{x: 0, y: 0}, instructions: [{"R", 2}, {"L", 3}]}
  """

  def assemble_directions(instructions) do
    directions = Enum.map instructions, fn(direction_set) ->
      {direction, distance} = String.split_at(direction_set,1)
      {direction, String.to_integer(distance)}
    end

    %Day1.Navigator{instructions: directions}
  end

  def navigate(navigator) do
    navigators = Enum.each navigator.instructions, fn({direction, distance}) ->
      navigator = move(navigator, direction, distance)
      navigate(navigator)
    end
  end

  @doc """
    Turns the navigator in the right direction, and moves the distance

    ## Examples:
      iex> Day1.move(%Day1.Navigator{}, "R", 10)
      %Day1.Navigator{compass: {:e, :s, :w, :n}, coordinates: %{x: 10, y: 0}, instructions: nil}
  """

  def move(navigator, direction, distance) do
    %Day1.Navigator{} =
      navigator
      |> turn(direction)
      |> walk(distance)
  end

  @doc """
    Turns in the right cardinal direction

    ## Examples:
      iex> Day1.turn(%Day1.Navigator{}, "L")
      %Day1.Navigator{compass: {:w, :n, :e, :s}, coordinates: %{x: 0, y: 0}, instructions: nil}
  """

  def turn(navigator, direction) do
    case direction do
      "L" -> turn_left(navigator)
      "R" -> turn_right(navigator)
    end
  end

  @doc """
    Shifts the compass to the right.

    ## Examples:
      iex> Day1.turn_right(%Day1.Navigator{})
      %Day1.Navigator{compass: {:e, :s, :w, :n}, coordinates: %{x: 0, y: 0}, instructions: nil}
  """
  def turn_right(%Day1.Navigator{compass: compass} = navigator) do
    {first,_ ,_ ,_ } = compass
    new_compass = compass
      |> Tuple.delete_at(0)
      |> Tuple.append(first)

    %Day1.Navigator{ navigator | compass: new_compass}
  end


  @doc """
    Shifts the compass to the left.

    ## Examples:
      iex> Day1.turn_left(%Day1.Navigator{})
      %Day1.Navigator{compass: {:w, :n, :e, :s}, coordinates: %{x: 0, y: 0}, instructions: nil}
  """
  def turn_left(%Day1.Navigator{compass: compass} = navigator) do
    { _, _, _, last } = compass
    new_compass = compass
      |> Tuple.delete_at(3)
      |> Tuple.insert_at(0,last)

    %Day1.Navigator{ navigator | compass: new_compass}
  end

  @doc """
    Increments coordinates positively for North and East, and Negatively for West and South

    ## Examples:
      iex> distance = 5
      iex> Day1.walk(%Day1.Navigator{}, distance)
      %Day1.Navigator{compass: {:n, :e, :s, :w}, coordinates: %{x: 0, y: 5}, instructions: nil}
  """

  def walk(%Day1.Navigator{compass: compass, coordinates: coordinates} = navigator, distance) do
    new_coordinates = case compass do
      {:n,_ ,_ ,_ } -> Map.update!(coordinates, :y, &(&1 + distance))
      {:e,_ ,_ ,_ } -> Map.update!(coordinates, :x, &(&1 + distance))
      {:s,_ ,_ ,_ } -> Map.update!(coordinates, :y, &(&1 - distance))
      {:w,_ ,_ ,_ } -> Map.update!(coordinates, :x, &(&1 - distance))
    end
    %Day1.Navigator{ navigator | coordinates: new_coordinates}
  end

  def report(navigator) do
    "We are at #{navigator.coordinates.x}, #{navigator.coordinates.y}"
  end
end
