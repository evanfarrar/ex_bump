A BMP file writer in pure Elixir.

EXAMPLES:
```elixir
pixel_data = [[[0xFF,0xFF,0xFF],[0x00,0x00,0x00]],[[0x00,0x00,0x00],[0xFF,0xFF,0xFF]]]
Bump.write(filename: "file.bmp", pixel_data: pixel_data)
pixel_data = Bump.read("file.bmp")

canvas = Canvas.size(%Size{height: 400, width: 400}) |>
	    Canvas.fill(canvas, color: Color.named(:red))

Bump.write(filename: "red.bmp", canvas: canvas)
canvas2 = Canvas.fill(canvas, color: Color.named(:blue),
			       rect: %Rect{ size: %Size{height: 200, width: 200},
			     origin: %Point{x: 100, y: 100}})
Bump.write(filename: "redblue.bmp", canvas: canvas2)
```
