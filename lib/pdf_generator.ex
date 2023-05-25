defmodule PdfGenerator do
  @type path :: String.t()
  @type options :: [Keyword.t()]
  @callback convert_path_to_pdf(path(), options()) :: {:ok, any()} | {:error, any()}

  @doc """
  Converts a path to a PDF.

  For more information, refer to the documentation of the adapter you are using. 
  """
  def convert_path_to_pdf(path, options \\ []) do
    adapter().convert_path_to_pdf(path, options)
  end

  def adapter do
    :pdf_generator
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:adapter, PdfGenerator.GotenbergAdapter)
  end
end
