⚠️ BRANCH MAIN IS DEPRECATED ⚠️
Change your mix file to use a specific tag instead
# Elixir Pdf Generator

## Installation

```elixir
def deps do
  [
    {:elixir_pdf_generator, git: "git@github.com:rum-and-code/elixir-pdf-generator.git", tag: "v0.1.2"}
  ]
end
```
Once you've added PdfGenerator to your list, update your dependencies by running:

```
$ mix deps.get
```

## Configuration
This lib is just a tiny wrapper to call our Gotenburg service. But it is build to accept different adapter if we change service one day.

Here are the config needed for the Gotenberg Adapter.
```elixir
config :pdf_generator,
  adapter: PdfGenerator.GotenbergAdapter, #Defaults to GotenbergAdapter if not specified.
  host_url: "http://your-app.com",
  pdf_generator_url: "http://your-gotenburg-service.com"
```

