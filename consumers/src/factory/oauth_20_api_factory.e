note
	description: "Summary description for {OAUTH_20_API_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_API_FACTORY

feature -- Foursquare API Factory
	new_foursquare_api : OAUTH_FOURSQUARE_API_20
		do
			create Result
		end

end
