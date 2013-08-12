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
			l_key: STRING
			reduced_key: READABLE_INTEGER_X
			i_key_pad: READABLE_INTEGER_X
			o_key_pad: READABLE_INTEGER_X
			ipad: STRING
			opad: STRING
		do
			create l_key.make_from_string (a_key)
			if l_key.count > 64 then
				l_key := a_hash.hash (l_key)
			end
			if l_key.count < 64 then
				l_key.append (create {STRING}.make_filled ('%U', 64 - l_key.count))
			end
			create ipad.make_filled ('%/54/', 64)
			create opad.make_filled ('%/92/', 64)
			perform_xor (ipad, l_key)
			perform_xor (opad, l_key)
			Result := a_hash.hash (opad + a_hash.hash (ipad + a_msg))
		end

feature {NONE} -- Implementation

	bytestring (i: READABLE_INTEGER_X): STRING
		do
			Result := i.out_base (16).as_lower
		end

	build_bytes (key_a: READABLE_STRING_8): INTEGER_X
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

	perform_xor (s, a_key: STRING)
			-- Perform xor of every byte in `s' with `key' and put the
			-- result in `s's.
		require
			s_has_proper_length: s /= Void and then s.count = 64
			key_has_proper_length: a_key /= Void and then a_key.count = 64
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count
			loop
				s.put ((s.item (i).code.bit_xor (a_key.item (i).code)).to_character, i)
				i := i + 1
			end
		end

	hex_to_bin (str: STRING) : STRING
		local

		do
			Result := ""
		end

	map_character_binary_string: HASH_TABLE [STRING,CHARACTER]
		once
			create Result.make (16)
			Result.force ("0000", '0')
			Result.force ("0001", '1')
			Result.force ("0010", '2')
			Result.force ("0011", '3')
			Result.force ("0100", '4')
			Result.force ("0101", '5')
			Result.force ("0110", '6')
			Result.force ("0111", '7')
			Result.force ("1000", '8')
			Result.force ("1001", '9')
			Result.force ("1010", 'A')
			Result.force ("1011", 'B')
			Result.force ("1100", 'C')
			Result.force ("1101", 'D')
			Result.force ("1110", 'E')
			Result.force ("1110", 'F')
		end

end
