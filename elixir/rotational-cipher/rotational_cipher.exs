defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> shift_english_alphabets(x, shift) end)
    |> List.to_string()
  end

  defp shift_english_alphabets(c, shift) when (c <= 122 and c >= 97) do
    c
    |> Kernel.-(97)
    |> Kernel.+(shift)
    |> Kernel.rem(26)
    |> Kernel.+(97)
  end
  defp shift_english_alphabets(c, shift) when (c <= 90 and c >= 65) do
    c
    |> Kernel.-(65)
    |> Kernel.+(shift)
    |> Kernel.rem(26)
    |> Kernel.+(65)
  end
  defp shift_english_alphabets(c, shift), do: c
end
