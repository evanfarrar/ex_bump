defmodule BumpTest do
  use ExUnit.Case

  test "it interprets the height and width when given a properly dense matrix" do
    Bump.write(filename: "_build/4x4.bmp", pixel_data: [[[0xFF,0xFF,0xFF],[0x00,0x00,0x00]],[[0x00,0x00,0x00],[0xFF,0xFF,0xFF]]])
    {:ok, test_file} = File.read "_build/4x4.bmp"
    {:ok, fixture_file} = File.read "test/fixtures/4x4.bmp"
    assert(fixture_file == test_file)
  end

  test "it reads in pixel data" do
    expected_pixel_data = [[[0x00,0x00,0x00],[0xFF,0xFF,0xFF]],[[0xFF,0xFF,0xFF],[0x00,0x00,0x00]]]
    Bump.write(filename: "_build/4x4.bmp", pixel_data: expected_pixel_data)
    assert(expected_pixel_data == Bump.pixel_data("_build/4x4.bmp"))
  end

end
