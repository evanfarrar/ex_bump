defmodule Bump do
  def write(filename: filename, pixel_data: pixels) do
    {:ok, file} = File.open filename, [:write]

    resolution = 2835
    info_header_size = 40
    offset = 14 + info_header_size
    height = length(pixels)
    width = length(Enum.fetch!(pixels, 0))

    padding_size = rem(width,4)
    padding = (Stream.cycle([0]) |> Stream.take(padding_size) |> Enum.to_list)
    pixel_data = Enum.map(pixels, fn(row) -> List.flatten(row) ++ padding end) |> :binary.list_to_bin

    size_of_file = byte_size(pixel_data) + offset

    header = << 0x42, 0x4d,
                size_of_file :: unsigned-little-integer-size(32),
                0x0 :: size(32),
                offset :: unsigned-little-integer-size(32),
                info_header_size :: unsigned-little-integer-size(32),
                height :: unsigned-little-integer-size(32),
                width :: unsigned-little-integer-size(32),
                1 :: unsigned-little-integer-size(16), # color plane
                24 :: unsigned-little-integer-size(16), # bits per pixel (color depth)
                0x0 :: unsigned-little-integer-size(32), # disable compression
                byte_size(pixel_data) :: unsigned-little-integer-size(32), # size of image
                resolution :: unsigned-little-integer-size(32), # horizontal resolution
                resolution :: unsigned-little-integer-size(32), # vertical resolution
                0x0 :: unsigned-little-integer-size(32), # colors
                0x0 :: unsigned-little-integer-size(32) # important colors
                >>


    IO.binwrite file, header <> pixel_data
    File.close(file)
  end

  def pixel_data(filename) do
    {:ok, filedata} = File.read filename
    << 0x42, 0x4d, _size_of_file :: unsigned-little-integer-size(32), _unused :: size(4)-binary,
      offset :: unsigned-little-integer-size(32),
      _info_header_size :: unsigned-little-integer-size(32),
      _height :: unsigned-little-integer-size(32),
      width :: unsigned-little-integer-size(32),
      _unused2 :: binary >> = filedata
    << _header :: size(offset)-binary, data :: binary >> = filedata
    row_length = width*3 + rem(width*3, 4)
    Stream.chunk(:binary.bin_to_list(data), 8) |>
      Stream.map(fn(row) -> Enum.slice(row,0..width*3-1) |> Enum.chunk(3) end) |> Enum.to_list
  end
end
