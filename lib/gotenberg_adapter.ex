defmodule PdfGenerator.GotenbergAdapter do
  @behaviour PdfGenerator

  defp caller_url, do: Application.fetch_env!(:pdf_generator, :caller_url)
  defp pdf_generator_url, do: Application.fetch_env!(:pdf_generator, :pdf_generator_url)

  @impl PdfGenerator
  @doc """
  Converts a path to a PDF.

  ## Examples

      iex> PdfGenerator.convert_path_to_pdf("/path/to/template")
      {:ok, "PDF content"}

  ## Options
  Refer to https://gotenberg.dev/docs/modules/chromium for a list of available options.

  By default, we use the option `prefer_css_page_size: true`. This allow us to use the @page css rule to define the page size.
  """
  def convert_path_to_pdf(path, options \\ []) do
    url = caller_url() <> path

    url
    |> build_body(options)
    |> build_request()
    |> HTTPoison.request()
    |> case do
      {:ok, response} -> {:ok, response.body}
      {:error, error} -> {:error, error}
    end
  end

  defp headers() do
    [
      {"Content-Type", "multipart/form-data"}
    ]
  end

  defp build_body(url, options) do
    defaults = [
      url: url,
      prefer_css_page_size: true
    ]

    defaults
    |> Keyword.merge(options)
    |> Enum.map(fn {key, value} ->
      {Utils.Casing.camelize(key), to_string(value)}
    end)
  end

  defp build_request(body) do
    %HTTPoison.Request{
      method: :post,
      url: pdf_generator_url(),
      headers: headers(),
      body: {:multipart, body}
    }
  end
end
