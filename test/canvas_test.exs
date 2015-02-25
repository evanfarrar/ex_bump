defmodule CanvasTest do
  use ExUnit.Case

# test ".size when passed an empty canvas returns a canvas of that size" do
#   expected = [[%Color{ }, %Color{ }, %Color{ }, %Color{ }],
#               [%Color{ }, %Color{ }, %Color{ }, %Color{ }],
#               [%Color{ }, %Color{ }, %Color{ }, %Color{ }],
#               [%Color{ }, %Color{ }, %Color{ }, %Color{ }]]
#   assert expected == Canvas.size(%Canvas{ }, height: 4, width: 4).pixels
# end

  test ".size without a canvas returns a canvas of that size" do
    expected = [[%Color{ }, %Color{ }, %Color{ }],
                [%Color{ }, %Color{ }, %Color{ }],
                [%Color{ }, %Color{ }, %Color{ }],
                [%Color{ }, %Color{ }, %Color{ }]]
    assert expected == Canvas.size(%Size{height: 4, width: 3}).pixels
  end

  test ".size with a canvas but no size returns the size" do
    pixels = [[%Color{ }, %Color{ }],
              [%Color{ }, %Color{ }],
              [%Color{ }, %Color{ }]]
    assert %Size{ height: 3, width: 2 } == Canvas.size(%Canvas{ pixels: pixels })

  end

  test ".fill with a color" do
    newcanvas = Canvas.fill(Canvas.size(%Size{ height: 10, width: 10 }), color: Color.named(:red))
    newcanvas.pixels |> Enum.map(fn(row) -> Enum.map(row, fn(pixel) -> assert pixel == Color.named(:red) end) end)
  end

  test ".fill with a color and a rectangle that is part of the image" do
    canvas = Canvas.fill(Canvas.size(%Size{ height: 2, width: 2 }), color: Color.named(:red))
    newcanvas = Canvas.fill(canvas, color: Color.named(:blue), rect: %Rect{ size: %Size{ height: 2, width: 1 }, origin: %Point{ x: 1, y: 0 } } )
    assert [[Color.named(:red), Color.named(:blue)],[Color.named(:red), Color.named(:blue)]] == newcanvas.pixels
    first_pixel = Enum.fetch!(Enum.fetch!(newcanvas.pixels,0), 0)
    assert 0xFF == first_pixel.red
  end

  test ".pixel_data" do
    pixels = [[%Color{ }, %Color{ }],
              [%Color{ }, %Color{ }],
              [%Color{ }, %Color{ }]]
    pixel_data = [[[0x00,0x00,0x00],[0x00,0x00,0x00]],
                  [[0x00,0x00,0x00],[0x00,0x00,0x00]],
                  [[0x00,0x00,0x00],[0x00,0x00,0x00]]]

    assert pixel_data == Canvas.pixel_data(%Canvas{ pixels: pixels })
  end
end
