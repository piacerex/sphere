defmodule SphereWeb.ApiView do
	use SphereWeb, :view

	def render( "api.json", %{ api_data: params } ) do
		params
	end
end
