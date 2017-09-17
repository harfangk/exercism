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
    code
    |> get_five_least_significant_bits_of()
    |> decipher_code()
   end

   defp get_five_least_significant_bits_of(code) do
     rem(code, 32)
   end

  defp decipher_code(code) do
    table = [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ]
    has_event? = fn(x) -> ((code &&& x) == x) end
    actions = for {k, v} <- table, has_event?.(k), into: [], do: v
    if (code &&& 16) == 16 do
      Enum.reverse(actions)
    else
      actions
    end
  end 
end
