note
	description: "Summary description for {OAUTH_10_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_10_API
inherit

	OAUTH_API

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {TOKEN_EXTRACTOR_10} Result
		end

	base_string_extractor : BASE_STRING_EXTRACTOR
		do

		end

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := "GET"
		end

	access_token_endpoint: READABLE_STRING_GENERAL
			-- Url that receives the access token request
		deferred
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		deferred
		end

feature -- Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
		deferred
--			create {OAUTH_10_SERVICE} Result.make (Current, config)
		end

end
