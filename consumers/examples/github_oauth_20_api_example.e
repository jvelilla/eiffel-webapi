note
	description: "Summary description for {GITHUB_OAUTH_20_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GITHUB_OAUTH_20_API_EXAMPLE

create
	make

feature -- Access

	make
		local
			box: OAUTH_20_GITHUB_API
			config: OAUTH_CONFIG
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			access_token: detachable OAUTH_TOKEN
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1")
			config.set_scope ("user,repo,public_repo")
			create box
			api_service := box.create_service (config)
			print ("%N===Github API OAuth Workflow ===%N")

				-- Obtain the Authorization URL
			print ("%NFetching the Authorization URL...");
			if attached api_service.authorization_url (empty_token) as lauthorization_url then
				print ("%NGot the Authorization URL!%N");
				print ("%NNow go and authorize here:%N");
				print (lauthorization_url);
				print ("%NAnd paste the authorization code here%N");
				io.read_line
			end
			access_token := api_service.access_token_post (empty_token, create {OAUTH_VERIFIER}.make (io.last_string))
			if attached access_token as l_access_token then
				print ("%NGot the Access Token!%N");
				print ("%N(Token: " + l_access_token.debug_output + " )%N");

					--Now let's go and ask for a protected resource!
				print ("%NNow we're going to access a protected resource...%N");
				create request.make ("GET", protected_resource_url)
				request.add_header ("Authorization", "Bearer " + l_access_token.token)
				api_service.sign_request (l_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:" + l_body)
					end
				end
			end
		end

feature {NONE} -- Implementation

	api_key: STRING = "COMPLETE"

	api_secret: STRING = "COMPLETE"

	protected_resource_url: STRING = "https://api.github.com/user"
	protected_resource_url_emails: STRING = "https://api.github.com/user/emails"
	protected_resource_url_user_repos: STRING = "https://api.github.com/users/jocelyn/repos"

	empty_token: detachable OAUTH_TOKEN

end
