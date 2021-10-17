defmodule FileSniffer do
  def type_from_extension(extension) do
    case String.downcase(extension) do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
    end
  end

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>) do
    "application/octet-stream"
  end

  def type_from_binary(<<0x42, 0x4D, _::binary>>) do
    "image/bmp"
  end

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>) do
    "image/png"
  end

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>) do
    "image/jpg"
  end

  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>) do
    "image/gif"
  end

  def verify(file_binary, extension) do
    binary_type = type_from_binary(file_binary)
    extension_type = type_from_extension(extension)

    if binary_type == extension_type do
      {:ok, binary_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
