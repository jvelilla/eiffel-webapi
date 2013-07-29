note
	description: "Objects that represent an OAuth Parameter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER

	inherit
		COMPARABLE
create
	make
feature	{NONE} --Initialization	
	make (a_key : READABLE_STRING_8; a_value : READABLE_STRING_8)
		do
			key := a_key
			value := a_value
		end
feature -- Access
	key : READABLE_STRING_8
	value : READABLE_STRING_8

feature -- Conversion
	as_url_enconded : STRING_8
		do
			Result := url_encoded_string(key)
			Result.append ("=")
			Result.append (url_encoded_string(value))
		end
feature -- Comparision
	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if key.is_less (other.key) then
				Result := True
			end
		end

feature {NONE} -- Implementation
	url_encoded_string (s: STRING_32): STRING_8
		do
			Result := url_encoder.encoded_string (s)
		end

	url_encoder: URL_ENCODER
		once
			create Result
		end

end
