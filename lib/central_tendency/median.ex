defmodule Stats.CentralTendency.Median do
  require Integer
  alias Stats.{Errors, Validators}

  def median(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_median()
  end

  def median(_), do: Errors.invalid_data_type()

  defp calc_median({:error, _msg}), do: Errors.invalid_data_type()
  defp calc_median({false, _}), do: Errors.invalid_data_type()
  defp calc_median({true, []}), do: Errors.invalid_data_type() # Handle empty list case
  defp calc_median({true, nums}) do
    count = Enum.count(nums)
    nums
    |> Enum.sort()
    |> get_median(Integer.is_even(count), count)
  end

  defp get_median(nums, false, count), do: Enum.at(nums, div(count, 2))
  defp get_median(nums, true, count) do
    a = Enum.at(nums, div(count - 1, 2))
    b = Enum.at(nums, div(count, 2))
    (a + b) / 2
  end
end
