defmodule PdfGenerator.GotenbergAdapter do
  @moduledoc """
  This module provides an adapter for the Gotenberg API.
  """

  @behaviour PdfGenerator
  @type path :: String.t()
  @type options :: [Keyword.t()]
  @type request_options :: [Keyword.t()]

  defp host_url, do: Application.fetch_env!(:pdf_generator, :host_url)
  defp pdf_generator_url, do: Application.fetch_env!(:pdf_generator, :pdf_generator_url)

  @impl PdfGenerator
  @doc """
  Converts a path to a PDF.

  ## Examples

      iex> PdfGenerator.convert_path_to_pdf("/path/to/template")
      {:ok, "PDF content"}

  ## Options
  Refer to https://gotenberg.dev/docs/modules/chromium for a list of available options.

  By default, we use the option `prefer_css_page_size: true`. This allow us to use the @page css rule to define the page size like so
  ```css
  @page {
    size: letter landscape;
  }
  ```
  """
  @spec convert_path_to_pdf(path(), options(), request_options()) ::
          {:ok, binary()} | {:error, any()}
  def convert_path_to_pdf(path, options, request_options) do
    url = host_url() <> path
    headers = [{"Content-Type", "multipart/form-data"}]

    body =
      [url: url, prefer_css_page_size: true]
      |> Keyword.merge(options)
      |> Enum.map(fn {key, value} ->
        {PdfGenerator.Utils.Casing.camelize(key), to_string(value)}
      end)

    request =
      %HTTPoison.Request{
        method: :post,
        url: "#{pdf_generator_url()}/forms/chromium/convert/url",
        headers: headers,
        body: {:multipart, body},
        options: request_options
      }

    case HTTPoison.request(request) do
      {:ok, response} -> {:ok, response.body}
      {:error, error} -> {:error, error}
    end
  end

  def health do
    request =
      %HTTPoison.Request{
        method: :get,
        url: "#{pdf_generator_url()}/health"
      }

    case HTTPoison.request(request) do
      {:ok, response} -> {:ok, response.body}
      {:error, error} -> {:error, error}
    end
  end
end
