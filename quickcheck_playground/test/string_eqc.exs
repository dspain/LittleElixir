defmodule StringEQC do
  use ExUnit.Case
  use EQC.ExUnit

  property "splitting a string with a delimiter and joining it again yields the same string" do
    forall s <- list(char) do
      s = to_string(s)
      ensure(String.split(s, ",") |> join(",") == s)
    end
  end

  def join(parts, delimiter) do
    parts |> Enum.intersperse([delimiter]) |> Enum.join()
  end
end
