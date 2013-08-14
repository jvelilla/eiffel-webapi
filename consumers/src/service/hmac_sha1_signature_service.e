note
	description: "Summary description for {HMAC_SHA1_SIGNATURE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HMAC_SHA1_SIGNATURE_SERVICE

inherit

	SIGNATURE_SERVICE


feature -- Access

	signature (base_string: READABLE_STRING_GENERAL; api_secret: READABLE_STRING_GENERAL; token_secret: READABLE_STRING_GENERAL): STRING_32
			-- Return a signature
			-- `base_string' url-encoded string to sign
			-- `api_secret' api secret for your app
			-- `token_secret' token secret (empty string for the request token step)
		local
			l_encoder: OAUTH_ENCODER
			l_encoder2: UTF8_ENCODER
		do
			create l_encoder
			Result := do_sign (base_string, l_encoder.encoded_string (api_secret.as_string_8) + "&" + l_encoder.encoded_string (token_secret.as_string_8))
		end

	signature_method: STRING_32
			-- Return the signature algorithm
		once
			Result := Method
		ensure then
			method_hmac_sha1: Result = Method
		end


feature {NONE} --Implementation

 	Empty_string: STRING = "";

  	Carriage_return: STRING = "%R";

  	Utf8: STRING = "UTF-8";

  	Method: STRING = "HMAC-SHA1";

	do_sign (to_sing: READABLE_STRING_GENERAL; key: READABLE_STRING_GENERAL): STRING
		local
			l_hmac_sha1: HMAC_SHA1
			str : STRING
		do
			create l_hmac_sha1.make_ascii_key (key.as_string_8)
			l_hmac_sha1.sink_string (to_sing.as_string_8)
			l_hmac_sha1.finish
			print (bytes_to_string (l_hmac_sha1.hmac.as_bytes))
			str := l_hmac_sha1.hmac.out_decimal
			str.remove_head (2)
			Result := (create{SHARED_BASE64}).base64_encoder.encoded_string(str)
			Result.replace_substring_all (Carriage_return, Empty_string)
		end

	bytes_to_string (a_bytes: SPECIAL[NATURAL_8]) : STRING
		local
			i: INTEGER
			l_encoder: UTF8_ENCODER
		do
			create Result.make_empty
			from
			  i := 0
			until
				i >= a_bytes.count
			loop
				Result.append_character(to_byte(a_bytes.at (i).as_integer_8).to_character_8)
				i:= i + 1
			end
			create l_encoder
			Result := (create{SHARED_BASE64}).base64_encoder.encoded_string(l_encoder.encoded_string (Result))
		end

	to_byte (a_val : INTEGER) : INTEGER_8
			-- takes a value between 0 and 255
			-- Result :-128 to 127
		do
			if a_val >= 128 then
				Result := (-256 + a_val).to_integer_8
			else
				Result := a_val.to_integer_8
			end
		ensure
			result_value :  127 >= Result and Result >= -128
		end
end
