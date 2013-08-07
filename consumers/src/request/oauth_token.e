note
	description: "Represents an OAuth token (either request or access token) and its secret"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Access Token", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-1.4", "protocol=uri"
	EIS: "name=Refresh Token", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-1.5", "protocol=uri"

	--| OAuth2.0, there is no token secret, but refresh_token instead.
	--| We can write it by hand doing something like
	--| request.add_body_parameter("grant_type", "refresh_token")
	--| request.add_body_parameter("refresh_token", access_token.token)
	--| were access_token is the Token object you want to refresh.

class
	OAUTH_TOKEN

inherit

	ANY
		redefine
			is_equal
		end

create
	make_empty, make_token_secret, make_token_secret_response, make_token_secret_response_refresh

feature {NONE} -- Initilization

	make_empty
		do
			create token.make_empty
			create secret.make_empty
		ensure
			token_empty_set: token.is_empty
			secret_empty_set: secret.is_empty
		end

	make_token_secret (a_token: STRING; a_secret: STRING)
		do
			token := a_token
			secret := a_secret
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

	make_token_secret_response (a_token: STRING; a_secret: STRING; a_response: like raw_response)
		do
			token := a_token
			secret := a_secret
			raw_response := a_response
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

	make_token_secret_response_refresh (a_token: STRING; a_secret: STRING; a_response: like raw_response; a_refresh: like refresh_token)
		do
			token := a_token
			secret := a_secret
			raw_response := a_response
			refresh_token := a_refresh
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			if token.same_string (other.token) and then secret.same_string (other.secret) then
				Result := True
			end
		end

feature -- Access

	token: STRING

	secret: STRING

	raw_response: detachable STRING

	refresh_token: detachable STRING

feature -- debug

	debug_output: STRING
		do
			create Result.make_from_string ("Token {")
			Result.append (token + ", ")
			Result.append (secret + "}")
		end

end
