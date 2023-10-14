defmodule LunarisApi.PointPercentage do
  @moduledoc """
  Module for managing point percentage configuration.
  """

  @percentage Application.get_env(:lunaris_api, :point_percentage, 1.0)

  @spec percentage() :: float
  def percentage do
    @percentage
  end
end
