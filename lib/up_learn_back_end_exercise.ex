defmodule UpLearnBackEndExercise do
  @moduledoc """
  Documentation for `UpLearnBackEndExercise`.
  """

  alias UpLearnBackEndExercise.Elements.Link
  alias UpLearnBackEndExercise.Elements.Asset



  @doc """
    send an url to client that try to connects, if successful it will returns a string containing an HTML document.

    ## Parameters

      - url: String that corresponds an url access link.

    ## Examples

    iex> UpLearnBackEndExercise.fetch_link("https://www.site1.com")
    {:ok, "<html> <> ..."}

    iex> UpLearnBackEndExercise.fetch_link("https://www.site2.com")
    {:error, 404}
  """
  @spec fetch_link(String.t()) :: {:error, Integer.t()} | {:ok, String.t()}
  def fetch_link(url) do
    with {:ok, html} <- UpLearnBackEndExerciseClient.TeslaClient.get_html(url),
         {:ok, document} <- Floki.parse_document(html) do
      {:ok, document}
    else
      {:error, status} -> {:error, status}
    end
  end



  @doc """
    get all <a> tags in a HTML document, and apply in a Link Schema.

    ## Parameters

      - html: String that an entire HTML document.

    ## Examples

    iex> UpLearnBackEndExercise.get_links("<html> <a href="oi"> </a> </html>")
    { :ok, [ %UpLearnBackEndExercise.Elements.Link{href: "oi"} ] }

    iex> UpLearnBackEndExercise.get_links("<html> </html>")
    {:ok, []}

    iex> UpLearnBackEndExercise.get_links("")
    {:ok, []}
  """
  @spec get_links(String.t()) :: {:ok, list}
  def get_links(html) do
    html
    |> Floki.find("a")
    |> Enum.map(&(elem(&1, 1) |> Enum.into(%{})))
    |> Enum.map(&(Link.changeset(%Link{}, &1) |> Ecto.Changeset.apply_changes()))
    |> then(fn list -> {:ok, list} end)
  end



  @doc """
    get all <img> tags in a HTML document, and apply in a Asset Schema.

    ## Parameters

      - url: String that corresponds an url access link.

    ## Examples

    iex> UpLearnBackEndExercise.get_assets("<html> <img src="image"> </img> </html>")
    { :ok, [ %UpLearnBackEndExercise.Elements.Asset{src: "image"} ] }

    iex> UpLearnBackEndExercise.get_assets("<html> </html>")
    {:ok, []}

    iex> UpLearnBackEndExercise.get_assets("")
    {:ok, []}
  """
  @spec get_assets(String.t()) :: {:ok, list}
  def get_assets(html) do
    html
    |> Floki.find("img")
    |> Enum.map(&(elem(&1, 1) |> Enum.into(%{})))
    |> Enum.map(&(Asset.changeset(%Asset{}, &1) |> Ecto.Changeset.apply_changes()))
    |> then(fn list -> {:ok, list} end)
  end




  @doc """
    Give back a list contains all the images and links in the generated HTML file by the given url.

    ## Parameters

      - url: String that an entire HTML document.

    ## Examples


    iex> UpLearnBackEndExercise.fetch_link("https://www.site1.com")
    {:ok, [ %UpLearnBackEndExercise.Elements.Link{href: "oi"}, %UpLearnBackEndExercise.Elements.Asset{src: "image"} ]}

    iex> UpLearnBackEndExercise.fetch_link("https://www.site2.com")
    {:error, 404}
  """
  @spec fetch(String.t()) :: {:error, Integer.t()} | {:ok, list}
  def fetch(url) do
    with {:ok, html} <- fetch_link(url),
         {:ok, links} <- get_links(html),
         {:ok, assets} <- get_assets(html) do
      {:ok, links ++ assets}
    else
      {:error, error} ->
        {:error, error}
    end
  end
end
