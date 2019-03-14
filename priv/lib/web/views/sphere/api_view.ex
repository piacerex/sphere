defmodule SphereWeb.ApiView do
	use SphereWeb, :view

	def render( "api.json", %{ api_data: _params } ) do
		%{}
	end
end
