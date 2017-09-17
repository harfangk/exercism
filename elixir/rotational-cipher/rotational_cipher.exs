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
    |> Enum.map(&shift_english_alphabets(&1, shift))
    |> List.to_string()
  end

  defp shift_english_alphabets(c, shift) when c in ?A..?Z do
    rem(c - 65 + shift, 26) + 65
  end
  defp shift_english_alphabets(c, shift) when c in ?a..?z do
    rem(c - 97 + shift, 26) + 97
  end
  defp shift_english_alphabets(c, shift), do: c
end
