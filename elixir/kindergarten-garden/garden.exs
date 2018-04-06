defmodule Garden do
  @default_students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(info_string), do: do_info(info_string, @default_students)
  def info(info_string, student_names), do: do_info(info_string, Enum.sort(student_names))

  defp do_info(info_str, sorted_students) do
    [row1, row2] = String.split(info_str, "\n")
    build_info(sorted_students, row1, row2, %{})
  end

  defp build_info([], _row1, _row2, map_acc), do: map_acc

  defp build_info(
         [student | remaining_students],
         <<plant1, plant2, row1_rest::binary>>,
         <<plant3, plant4, row2_rest::binary>>,
         map_acc
       ) do
    new_map_acc = Map.merge(map_acc, %{student => plant_tuple(plant1, plant2, plant3, plant4)})
    build_info(remaining_students, row1_rest, row2_rest, new_map_acc)
  end

  defp build_info([student | remaining_students], "", "", map_acc) do
    new_map_acc = Map.merge(map_acc, %{student => {}})
    build_info(remaining_students, "", "", new_map_acc)
  end

  defp plant_tuple(plant1, plant2, plant3, plant4) do
    {
      letter_to_plant_atom(plant1),
      letter_to_plant_atom(plant2),
      letter_to_plant_atom(plant3),
      letter_to_plant_atom(plant4)
    }
  end

  defp letter_to_plant_atom(?C), do: :clover
  defp letter_to_plant_atom(?G), do: :grass
  defp letter_to_plant_atom(?R), do: :radishes
  defp letter_to_plant_atom(?V), do: :violets
end
