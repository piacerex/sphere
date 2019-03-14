defmodule SphereWeb.ApiController do
	use SphereWeb, :controller

	def save( conn, %{ "post" => %{ "path" => relative_path, "body" => body } } = params ) do
		pwd = File.cwd!()
		root = Application.fetch_env!( :sphere, :content_root )
		absolute_path = "#{ pwd }#{ root }#{ relative_path }"
		File.write( absolute_path, body )
		render( conn, "api.json", api_data: params )
	end
end
