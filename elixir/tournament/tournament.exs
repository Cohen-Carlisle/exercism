defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  @team_name_padding 31

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> preprocess_input()
    |> process_games()
    |> compute_columns()
    |> order_teams()
    |> to_scoreboard()
  end

  defp preprocess_input(input) do
    Enum.map(input, &String.split(&1, ";"))
  end

  defp process_games(input) do
    Enum.reduce(input, %{}, &do_process_games/2)
  end

  defp do_process_games([team1, team2, "win"], acc) do
    acc
    |> Map.update(team1, {1, 0, 0}, &add_win/1)
    |> Map.update(team2, {0, 0, 1}, &add_loss/1)
  end

  defp do_process_games([team1, team2, "draw"], acc) do
    acc
    |> Map.update(team1, {0, 1, 0}, &add_draw/1)
    |> Map.update(team2, {0, 1, 0}, &add_draw/1)
  end

  defp do_process_games([team1, team2, "loss"], acc) do
    acc
    |> Map.update(team1, {0, 0, 1}, &add_loss/1)
    |> Map.update(team2, {1, 0, 0}, &add_win/1)
  end

  defp do_process_games(_, acc) do
    acc
  end

  defp add_win({w, d, l}) do
    {w + 1, d, l}
  end

  defp add_draw({w, d, l}) do
    {w, d + 1, l}
  end

  defp add_loss({w, d, l}) do
    {w, d, l + 1}
  end

  defp compute_columns(team_map) do
    Enum.map(team_map, &do_compute_columns/1)
  end

  defp do_compute_columns({team, {w, d, l}}) do
    [
      name: team,
      mp: w + d + l,
      w: w,
      d: d,
      l: l,
      p: w * 3 + d
    ]
  end

  defp order_teams(teams) do
    teams
    |> Enum.sort_by(&Keyword.get(&1, :name))
    |> Enum.sort_by(&Keyword.get(&1, :p), &>=/2)
  end

  defp to_scoreboard(teams) do
    header = "#{String.pad_trailing("Team", @team_name_padding)}| MP |  W |  D |  L |  P"
    Enum.reduce(teams, header, &add_scoreboard_row/2)
  end

  defp add_scoreboard_row(team, acc) do
    acc <>
      "\n#{String.pad_trailing(team[:name], @team_name_padding)}" <>
      "|  #{team[:mp]} |  #{team[:w]} |  #{team[:d]} |  #{team[:l]} |  #{team[:p]}"
  end
end
