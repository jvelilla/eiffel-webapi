note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_HMAC_SET

inherit
	EQA_TEST_SET
	ARRAY_FACILITIES
		undefine
			default_create
		end


feature -- Test routines

	test_hmac_md5
		local
			hmac: HMAC_UTIL
			res: STRING
		do
			create hmac

			res := hmac.hmac_hexdigest ("key","The quick brown fox jumps over the lazy dog", create {MD5_HMAC_HASH})
			assert ("Expected", res.is_equal("80070713463e7749b90c2dc24911e275"))
		end

	test_hmac_sha1
		local
			hmac: HMAC_UTIL
			res: STRING
		do
			create hmac

			res := hmac.hmac_hexdigest ("key","The quick brown fox jumps over the lazy dog", create {SHA1_HMAC_HASH})
			assert ("Expected", res.is_equal("de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"))
		end

	test_hmac_tes_sha1
		local
			hmac: TEST_HMC_SHA1
			res: STRING
		do
			create hmac.make_ascii_key ("key")
			hmac.sink_string ("The quick brown fox jumps over the lazy dog")
		end


	test_hmac_sha256
		local
			hmac: HMAC_UTIL
			res: STRING
		do
			create hmac

			res := hmac.hmac_hexdigest ("key","The quick brown fox jumps over the lazy dog", create {SHA256_HMAC_HASH})
			assert ("Expected", res.is_equal("f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8"))
		end

	test_sha1
		local
			sha1 : SHA1_HMAC_HASH
			res : STRING
			r : INTEGER_X

		do

			create sha1

			res := sha1.hash ("79%%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"+ hash1)
			assert ("Expected", res.is_case_insensitive_equal ("de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"))
		end


feature {NONE} -- Implementation
	hash1 : STRING
		local
			sha1: SHA1
			output: SPECIAL [NATURAL_8]
			str : STRING
		do
			create sha1.make
			create output.make_filled (0, 20)
			sha1.sink_string ("]SO6666666666666666666666666666666666666666666666666666666666666The quick brown fox jumps over the lazy dog")
			sha1.do_final (output, 0)
			str := as_natural_32_be (output, 0).to_hex_string
			str.append (as_natural_32_be (output, 4).to_hex_string)
			str.append (as_natural_32_be (output, 8).to_hex_string)
			str.append (as_natural_32_be (output, 12).to_hex_string)
			str.append (as_natural_32_be (output, 16).to_hex_string)
			Result := str
		end
end


