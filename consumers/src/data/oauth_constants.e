note
	description: "Summary description for {OAUTH_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS : "name:OAuth1.0" ,"src=http://tools.ietf.org/html/rfc5849", "protocol=uri"
	EIS : "name:OAuth2.0" ,"src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31", "protocol=uri"
class
	OAUTH_CONSTANTS

feature -- Access
	TIMESTAMP : STRING = "oauth_timestamp";
	SIGN_METHOD : STRING = "oauth_signature_method";
	SIGNATURE : STRING = "oauth_signature";
	CONSUMER_SECRET : STRING = "oauth_consumer_secret";
	CONSUMER_KEY : STRING = "oauth_consumer_key";
	CALLBACK : STRING = "oauth_callback";
	VERSION : STRING = "oauth_version";
	NONCE : STRING = "oauth_nonce";
	PARAM_PREFIX : STRING = "oauth_";
	TOKEN : STRING = "oauth_token";
	TOKEN_SECRET : STRING = "oauth_token_secret";
	OUT_OF_BAND : STRING = "oob";
	VERIFIER : STRING = "oauth_verifier";
	HEADER : STRING = "Authorization";
	EMPTY_TOKEN : OAUTH_TOKEN
		do
			create Result.make_empty
		end
	SCOPE : STRING = "scope";

feature -- OAuth2.0
	ACCESS_TOKEN : STRING = "access_token";
	CLIENT_ID : STRING = "client_id";
	CLIENT_SECRET : STRING = "client_secret";
	REDIRECT_URI : STRING = "redirect_uri";
	CODE : STRING = "code";
	GRANT_TYPE : STRING = "grant_type"
	AUTHORIZATION_CODE : STRING = "authorization_code"
end
