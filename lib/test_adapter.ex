defmodule PdfGenerator.TestAdapter do
  @behaviour PdfGenerator

  @impl PdfGenerator
  def convert_path_to_pdf(_path, options \\ [success?: true]) do
    if Keyword.get(options, :success?) do
      {:ok, "PDF"}
    else
      {:error, "error"}
    end
  end
end
