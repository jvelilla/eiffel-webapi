note
	description: "Summary description for {OAUTH_ENCODER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_ENCODER

feature  -- Encode
	encoded_string (s: STRING_32): STRING_8
		do
			Result := url_encoder.encoded_string (s)
		end

feature {NONE} -- Implementation

	url_encoder: URL_ENCODER
		once
			create Result
		end


end
