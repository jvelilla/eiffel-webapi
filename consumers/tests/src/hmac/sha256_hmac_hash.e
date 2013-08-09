note
	description: "Summary description for {SHA256_HMAC_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHA256_HMAC_HASH

inherit
	HMAC_HASH

feature -- Access

	hash (t: STRING): STRING
		local
			sha256: SHA256
		do
			create sha256.make
			sha256.sink_string (t)
			Result := sha256.current_out
			Result.remove_head (2)
			Result.to_lower
		end


end
