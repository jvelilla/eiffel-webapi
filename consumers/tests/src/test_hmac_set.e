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

	test_hmac_sha256
		local
			hmac: HMAC_UTIL
			res: STRING
		do
			create hmac

			res := hmac.hmac_hexdigest ("key","The quick brown fox jumps over the lazy dog", create {SHA256_HMAC_HASH})
			assert ("Expected", res.is_equal("f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8"))
		end

end


