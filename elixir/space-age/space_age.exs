defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @seconds_in_year %{
    earth:   31_557_600,
    mercury: 7_600_544,
    venus:   19_414_149,
    mars:    59_354_033,
    jupiter: 374_355_659,
    saturn:  929_292_363,
    uranus:  2_651_370_019,
    neptune: 5_200_418_560
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / @seconds_in_year[planet]
  end
end
