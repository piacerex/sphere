defmodule SphereWeb.SphereController do
	use SphereWeb, :controller

	def index( conn, _params ), do: render( conn, "index.html" )

	def edit( conn, %{ "path1" => path1, "path2" => path2, "path3" => path3 } ), do: dispatch( "edit.html", conn, "#{ path1 }/#{ path2 }/#{ path3 }" )
	def edit( conn, %{ "path1" => path1, "path2" => path2 } ), do: dispatch( "edit.html", conn, "#{ path1 }/#{ path2 }" )
	def edit( conn, %{ "path1" => path1 } ), do: dispatch( "edit.html", conn, "#{ path1 }" )
	def edit( conn, _ ), do: dispatch( "edit.html", conn, "" )

	def show( conn, %{ "path1" => path1, "path2" => path2, "path3" => path3 } ), do: dispatch( "show.html", conn, "#{ path1 }/#{ path2 }/#{ path3 }" )
	def show( conn, %{ "path1" => path1, "path2" => path2 } ), do: dispatch( "show.html", conn, "#{ path1 }/#{ path2 }" )
	def show( conn, %{ "path1" => path1 } ), do: dispatch( "show.html", conn, "#{ path1 }" )
	def show( conn, _ ), do: dispatch( "show.html", conn, "" )

	def dispatch( template, conn, content_path ) do
		folder = Application.fetch_env!( :sphere, :content_folder )
		relative_path = "/#{ folder }/#{ content_path }"
		pwd = File.cwd!()
		root = Application.fetch_env!( :sphere, :content_root )
		absolute_path = "#{ pwd }#{ root }#{ relative_path }"
		if File.exists?( absolute_path ) do
			if File.dir?( absolute_path ) do
				render( conn, template, params: %{ "path" => relative_path, "body" => "ディレクトリです" } )
			else
				render( conn, template, params: %{ "path" => relative_path, "body" => File.read!( absolute_path ) } )
			end
		else
			if template == "edit.html" do
				render( conn, template, params: %{ "path" => relative_path, "body" => "" } )
			else
				render( conn, template, params: %{ "path" => relative_path, "body" => "存在しないパスです" } )
			end
		end
	end
	def template( :edit ), do: "edit.html"
	def template( :show ), do: "show.html"
end
