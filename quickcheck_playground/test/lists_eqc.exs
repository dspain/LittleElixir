defmodule ListsEQC do
  use ExUnit.Case
  use EQC.ExUnit

  property "reversing a list twice yields the original list" do
    forall l <- list(int) do
      ensure(l |> Enum.reverse() |> Enum.reverse() == l)
    end
  end

  property "encoding is the reverse of decoding" do
    forall bin <- binary do
      ensure(bin |> Base.encode64() |> Base.decode64!() == bin)
    end
  end

  property "sorting works" do
    forall l <- list(int) do
      ensure(l |> Enum.sort() |> is_sorted == true)
    end
  end

  def is_sorted([]), do: true

  def is_sorted(list) do
    list
    |> Enum.zip(tl(list))
    |> Enum.all?(fn {x, y} -> x <= y end)
  end
end
