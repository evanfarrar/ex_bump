defmodule Size do
  defstruct height: 0, width: 0
end
defmodule Point do
  defstruct x: 0, y: 0
end
defmodule Rect do
  defstruct size: %Size{ }, origin: %Point{ }
end
defmodule Canvas do
  defstruct pixels: [[%Color{ }]]

  def size(%Size{height: height, width: width}) do
    %Canvas{ pixels: Enum.map(0..height-1, fn(_acc) -> Enum.map(0..width-1, fn(_acc2) -> %Color{ } end) end) }
  end

  def size(canvas) do
    %Size{ height: length(canvas.pixels), width: length(Enum.fetch!(canvas.pixels, 0)) }
  end

  def rect(canvas) do
    %Rect{ size: Canvas.size(canvas) }
  end

  def fill(canvas, color: color) do
    %Canvas{ pixels: Enum.map(canvas.pixels, fn(row) -> Enum.map(row, fn(_pixel) -> color end) end) }
  end

  def fill(canvas, color: color, rect: rect) do
    pixels = Stream.with_index(canvas.pixels) |>
      Stream.map(
        fn({row, index}) ->
          if index >= rect.origin.y && index < rect.origin.y + rect.size.height do
            Stream.with_index(row) |>
              Stream.map(
                fn({pixel, index}) ->
                  if index >= rect.origin.x && index < rect.origin.x + rect.size.width do
                    color
                  else
                    pixel
                  end
                end) |> Enum.to_list
          else
            row
          end
        end
      ) |> Enum.to_list
    %Canvas{ pixels: pixels }
  end

# def paste(%Canvas{ } = top_canvas, onto: %Canvas{ } = bottom_canvas, at: [horizontal,vertical]) do
# end

# def paste(%Canvas{ } = top_canvas, onto: %Canvas{ } = bottom_canvas, rect: rect) do
# end

  def pixel_data(canvas) do
    Enum.map(canvas.pixels, fn(row) -> Enum.map(row, fn(pixel) -> Color.to_list(pixel) end) end)
  end
end

defimpl Inspect, for: Canvas do
  def inspect(_, _) do
    "%Canvas<pixels: PIXEL_DATA>"
  end
end
