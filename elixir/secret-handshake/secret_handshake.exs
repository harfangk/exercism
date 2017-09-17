defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    reverse_cond = (code &&& 16) == 16

    code
    |> get_five_least_significant_bits()
    |> decipher_code()
    |> reverse_if(reverse_cond)
  end

  defp get_five_least_significant_bits(code) do
    rem(code, 32)
  end

  defp decipher_code(code) do
    table = [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ]

    code_requires_event? = fn(x) -> ((code &&& x) == x) end

    for {k, v} <- table, code_requires_event?.(k), into: [], do: v
  end 

  defp reverse_if(actions, true), do: Enum.reverse(actions)
  defp reverse_if(actions, false), do: actions
end
