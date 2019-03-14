defmodule Sphere.MixProject do
  use Mix.Project

  def project do
    [
      app: :sphere,
      version: "0.1.0",
      elixir: "~> 1.8",
		description: "Markdown based easy CMS for Phoenix(Elixir Web Framework), it's generate Markdown files not using DB.", 
		package: 
		[
			maintainers: [ "piacere-ex" ], 
			licenses:    [ "Apache 2.0" ], 
			links:       %{ "GitHub" => "https://github.com/piacere-ex/sphere" }, 
		],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

	# Run "mix help deps" to learn about dependencies.
	defp deps do
		[
			{ :earmark,             "~> 1.3",    only: :dev }, 
			{ :ex_doc,              "~> 0.19",   only: :dev, runtime: false }, 
			{ :mix_test_watch,      "~> 0.9",    only: :dev, runtime: false }, 
		]
	end
end
