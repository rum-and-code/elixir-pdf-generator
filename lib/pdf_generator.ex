defmodule PdfGenerator do
  @moduledoc """
  This module provides a simple interface to convert a path to a PDF.
  """

  @type path :: String.t()
  @type options :: [Keyword.t()]
  @type request_options :: [Keyword.t()]
  @callback convert_path_to_pdf(path(), options(), request_options()) ::
              {:ok, binary()} | {:error, any()}

  @doc """
  Converts a path to a PDF.

  For more information, refer to the documentation of the adapter you are using.
  """
  @spec convert_path_to_pdf(path(), options(), request_options()) ::
          {:ok, binary()} | {:error, any()}
  def convert_path_to_pdf(path, options \\ [], request_options \\ []) do
    adapter().convert_path_to_pdf(path, options, request_options)
  end

  def adapter do
    Application.get_env(:pdf_generator, :adapter, PdfGenerator.GotenbergAdapter)
  end
end
