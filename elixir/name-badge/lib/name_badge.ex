defmodule NameBadge do
  def print(id, name, department) do
    {name, department}
    |> print_name_and_department()
    |> print_id_if_not_nil(id)
  end

  defp print_name_and_department({name, department}) do
    department_or_owner = department || "Owner"
    "#{name} - #{String.upcase(department_or_owner)}"
  end

  defp print_id_if_not_nil(name_and_department, id) do
    if is_nil(id) do
      name_and_department
    else
      "[#{id}] - " <> name_and_department
    end
  end
end
