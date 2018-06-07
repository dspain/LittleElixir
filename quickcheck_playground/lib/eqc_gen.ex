defmodule EQCGen do
  use EQC.ExUnit

  def string_with_fixed_length(len) do
    vector(len, char())
  end

  def string_with_variable_length do
    let len <- choose(1, 10) do
      vector(len, char())
    end
  end
end
