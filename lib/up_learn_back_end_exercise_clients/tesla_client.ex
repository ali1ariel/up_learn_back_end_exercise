defmodule UpLearnBackEndExerciseClient.TeslaClient do
  use Tesla

  plug Tesla.Middleware.JSON


  @spec get_html(String.t()) :: {:ok, String.t()} | {:error, Integer.t()}
  def get_html(link) do
    get!(link)
    |> response_handler()
  end


  defp response_handler(%{status: 200, body: body}), do: {:ok, body}
  defp response_handler(%{status: 201, body: body}), do: {:ok, body}
  defp response_handler(%{status: status}), do: {:error, status}
end
