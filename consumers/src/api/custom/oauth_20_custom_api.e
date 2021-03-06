note
	description: "Summary description for {OAUTH_20_CUSTOM_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_CUSTOM_API

inherit
	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

create
	make_get, make_post

feature {NONE} -- Initialization

	make_get (a_authorization_url_builder: like authorization_url_builder; a_end_point: like access_token_endpoint)
		do
			internal_access_token_verb := "GET"
			initialize (a_authorization_url_builder, a_end_point)
		end

	make_post (a_authorization_url_builder: like authorization_url_builder; a_end_point: like access_token_endpoint)
		do
			internal_access_token_verb := "POST"
			initialize (a_authorization_url_builder, a_end_point)
		end

	initialize (a_authorization_url_builder: like authorization_url_builder; a_end_point: like access_token_endpoint)
		do
			internal_access_token_endpoint := a_end_point
			create {TOKEN_EXTRACTOR_20} internal_access_token_extractor
			authorization_url_builder := a_authorization_url_builder
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			Result := internal_access_token_extractor
		end

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := internal_access_token_verb
		end

	access_token_endpoint: READABLE_STRING_GENERAL
			-- Url that receives the access token request
		do
			Result := internal_access_token_endpoint
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		do
			Result := authorization_url_builder.item ([config])
		end

feature -- Access

	authorization_url_builder: FUNCTION [ANY, TUPLE [OAUTH_CONFIG], READABLE_STRING_GENERAL]

feature {NONE} -- Implementation

	internal_access_token_extractor: like access_token_extractor
	internal_access_token_verb: like access_token_verb
	internal_access_token_endpoint: like access_token_endpoint

end
