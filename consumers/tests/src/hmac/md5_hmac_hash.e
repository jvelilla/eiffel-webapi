note
	description: "Summary description for {MD5_HMAC_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD5_HMAC_HASH

inherit
	HMAC_HASH

feature -- Access

	hash (t: STRING): STRING
		local
			md5: MD5
		do
			create md5.make
			md5.sink_string (t)
			Result := md5.current_out
			Result.remove_head (2)
			Result.to_lower
		end


end
