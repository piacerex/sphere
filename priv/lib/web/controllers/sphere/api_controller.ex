defmodule SphereWeb.ApiController do
	use SphereWeb, :controller

	def save( conn, %{ "post" => %{ "path" => relative_path, "body" => body } } = params ) do
		pwd = File.cwd!()
		root = Application.fetch_env!( :sphere, :content_root )
		absolute_path = "#{ pwd }#{ root }#{ relative_path }"
		File.write( absolute_path, body )
		render( conn, "api.json", api_data: params )
	end

	def upload(conn, %{"image" => image}) do
		pwd = File.cwd!()
		image_folder = Application.fetch_env!(:sphere, :image_folder)
		filename = :crypto.strong_rand_bytes(32) |> Base.encode64 |> binary_part(0, 32) |> String.replace("/", "")

		absolute_path = "#{pwd}/priv/static/images/#{image_folder}/#{filename}"

		File.cp!(image.path, "#{absolute_path}")
		render(conn, "api.json", api_data: %{"src" => Routes.static_path(conn, "/images/#{image_folder}/#{filename}")})
	end

end
