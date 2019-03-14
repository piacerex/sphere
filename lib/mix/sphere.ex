defmodule Mix.Tasks.Sphere.Put do
	use Mix.Task
	require Mix.Generator

	@shortdoc "Put Sphere (Sphere is easy CMS)"

	def run( _args ) do
		file_app_module = Mix.Project.config[ :app ] |> Atom.to_string
		# elixir_app_module = file_app_module |> Macro.camelize

		[
			%{ "path" => "lib/#{ file_app_module }_web/templates/sphere/edit.html.eex",				"id" => &edit_html_text/0 }, 
			%{ "path" => "lib/#{ file_app_module }_web/templates/sphere/show.html.eex",				"id" => &show_html_text/0 }, 
			%{ "path" => "lib/#{ file_app_module }_web/controllers/sphere/sphere_controller.ex",	"id" => &sphere_controller_text/0 }, 
			%{ "path" => "lib/#{ file_app_module }_web/controllers/sphere/api_controller.ex",		"id" => &api_controller_text/0 }, 
			%{ "path" => "lib/#{ file_app_module }_web/views/sphere/sphere_view.ex", 				"id" => &sphere_view_text/0 }, 
			%{ "path" => "lib/#{ file_app_module }_web/views/sphere/api_view.ex", 					"id" => &api_view_text/0 }, 
		]
		|> Enum.each( & Mix.Generator.create_file( &1[ "path" ], &1[ "id" ].() ) )

		folder = Application.fetch_env!( :sphere, :content_folder )
		relative_path = "/#{ folder }"
		pwd = File.cwd!()
		root = Application.fetch_env!( :sphere, :content_root )
		absolute_path = "#{ pwd }#{ root }#{ relative_path }"
		Mix.Generator.create_directory( absolute_path )

		IO.puts ""
		IO.puts """
			scope "/", SphereWeb do
				post "/api/save", ApiController, :save
			end

			scope "#{ root }#{ relative_path }", SphereWeb do
				pipe_through :browser

				get "/:path1/_edit",               SphereController, :edit
				get "/:path1/:path2/_edit",        SphereController, :edit
				get "/:path1/:path2/:path3/_edit", SphereController, :edit

				get "/:path1",                     SphereController, :show
				get "/:path1/:path2",              SphereController, :show
				get "/:path1/:path2/:path3",       SphereController, :show
			end
		"""
	end

	Mix.Generator.embed_text( :edit_html,			from_file: "priv/lib/web/templates/sphere/edit.html.eex" )
	Mix.Generator.embed_text( :show_html,			from_file: "priv/lib/web/templates/sphere/show.html.eex" )
	Mix.Generator.embed_text( :sphere_controller,	from_file: "priv/lib/web/controllers/sphere/sphere_controller.ex" )
	Mix.Generator.embed_text( :api_controller,		from_file: "priv/lib/web/controllers/sphere/api_controller.ex" )
	Mix.Generator.embed_text( :sphere_view,			from_file: "priv/lib/web/views/sphere/sphere_view.ex" )
	Mix.Generator.embed_text( :api_view,			from_file: "priv/lib/web/views/sphere/api_view.ex" )
end
