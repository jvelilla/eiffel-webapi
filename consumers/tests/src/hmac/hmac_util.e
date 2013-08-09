note
	description: "Summary description for {HMAC_UTIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HMAC_UTIL

feature

	hmac_hexdigest (a_key, a_msg: STRING; a_hash: HMAC_HASH): STRING
		local
			l_key : STRING
			reduced_key: READABLE_INTEGER_X
			i_key_pad : READABLE_INTEGER_X
			o_key_pad : READABLE_INTEGER_X
		do
			create l_key.make_from_string (a_key)
			if l_key.count > 64 then
				l_key := a_hash.hash (l_key)
			end
			if l_key.count < 64 then
				l_key.append (create {STRING}.make_filled ('%U', 64 - l_key.count))
			end
			reduced_key := build_bytes (l_key)
			i_key_pad := reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636"))
			o_key_pad := reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c"))

			Result := a_hash.hash (bytestring (o_key_pad) + a_hash.hash (bytestring (i_key_pad) + a_msg))
		end

feature {NONE} -- Implementation

	bytestring (i: READABLE_INTEGER_X): STRING
		do
			Result := i.out_base (16).as_lower
		end

	build_bytes	(key_a: READABLE_STRING_8): INTEGER_X
		local
			key_bytes: SPECIAL [NATURAL_8]
			i: INTEGER
		do
			create key_bytes.make_filled (0, key_a.count)
			from
				i := 1
			until
				i > key_a.count
			loop
				key_bytes [i - 1] := key_a [i].natural_32_code.to_natural_8
				i := i + 1
			end
			create Result.make_from_bytes (key_bytes, 0, key_bytes.count - 1)
		end

end
