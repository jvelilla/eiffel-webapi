note
	description: "Summary description for {PAYPAL_OAUTH_API_20_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYPAL_OAUTH_API_20_EXAMPLE
create
	make
feature -- Access	
	make
		local
			box : OAUTH_PAYPAL_API_20
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1")
			config.set_grant_type ("client_credentials")
			create box
			api_service := box.create_service (config)
			print ("%N===Paypal OAuth Workflow ===%N")

		   access_token := api_service.access_token_post (empty_token, Void)
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", protected_resource_url)
			  request.add_header("Authorization", "Bearer " + l_access_token.token )
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

	api_key : STRING ="AdzYXxATcMSu80k-KDbNRJWv5_nXtCO0gNCxzMcRH1hoCAz2ldpM6fae2UHO"
	api_secret :STRING ="EH4OmxCbGyTpGhS_NyR7ujQlS2vglUwv0mgQ9TDN6ovTMD_csIjY2D3Fu67-"
	protected_resource_url : STRING = "https://api.sandbox.paypal.com/v1/payments/"
 	empty_token : detachable  OAUTH_TOKEN


end
