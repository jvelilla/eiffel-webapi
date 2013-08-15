note
	description: "Summary description for {TWITTER_10_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_10_API_EXAMPLE

create
	make

feature {NONE} -- Initialization

	make
		local
			box: OAUTH_10_TWITTER_API
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token,request_token : detachable OAUTH_TOKEN
			signature: OAUTH_SIGNATURE_TYPE
		do
			create signature.make
			create config.make_default (api_key, api_secret)
			config.set_callback ("oob")
			config.set_signature_type (signature)
			create box
			api_service := box.create_service (config)
			print ("%N===Twitter OAuth Workflow ===%N")

		 	-- Obtain the Request Token
		 	print ("%NGet the request token%N")
			request_token := api_service.request_token

			-- Obtain the Authorization URL
    		print("%NFetching the Authorization URL...");
    		if attached api_service.authorization_url (request_token) as lauthorization_url then
			    print("%NGot the Authorization URL!%N");
			    print("%NNow go and authorize here:%N");
			    print(lauthorization_url);
			    print("%NAnd paste the authorization code here%N");
			    io.read_line
			end

		   access_token := api_service.access_token_get (request_token, create {OAUTH_VERIFIER}.make (io.last_string))
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("POST", protected_resource_url)
			  request.add_body_parameter ("status", "testing!!!")
	 		  api_service.sign_request (l_access_token, request)
	    	  if attached {OAUTH_RESPONSE} request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:"+l_body)
					end
	    	  end
		   end

 		end


feature {NONE} -- Implementation

	api_key : STRING ="6icbcAXyZx67r8uTAUM5Qw"
	api_secret :STRING ="SCCAdUUc6LXxiazxH3N0QfpNUvlUy84mZ2XZKiv39s"
	protected_resource_url : STRING = "https://api.twitter.com/1/statuses/update.json";
 	empty_token : detachable  OAUTH_TOKEN

end
