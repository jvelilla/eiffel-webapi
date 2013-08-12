note
	description: "Summary description for {SHA1_HMAC_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHA1_HMAC_HASH

inherit
	HMAC_HASH
	ARRAY_FACILITIES
feature -- Access

	hash (t: STRING): STRING
		local
			sha1: SHA1
		do
			create sha1.make
			sha1.sink_string (t)
			Result := sha1.current_out
			Result.remove_head (2)
			Result.to_lower
		end

end
