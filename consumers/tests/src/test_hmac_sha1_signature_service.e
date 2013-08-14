note
	description: "Summary description for {TEST_HMAC_SHA1_SIGNATURE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_SHA1_SIGNATURE_SERVICE

inherit

	EQA_TEST_SET

feature -- Tests


	test_return_signature
		local
			l_service : HMAC_SHA1_SIGNATURE_SERVICE
			l_expected: STRING
			l_integer : INTEGER_X
			l_sha1: SHA1_UTIL
		do
			l_expected := "NzNjYWM3MmUyZTY0ODRjZTJjYTFkY2ZlNmVjODJlNDEzYjJhNmNkOQ=="
			create l_sha1
			print (l_sha1.bytestring (l_sha1.build_bytes ("NzNjYWM3MmUyZTY0ODRjZTJjYTFkY2ZlNmVjODJlNDEzYjJhNmNkOQ==")))



			create l_service
			assert("Expected:NzNjYWM3MmUyZTY0ODRjZTJjYTFkY2ZlNmVjODJlNDEzYjJhNmNkOQ==", l_service.signature ("api secret", "token secret", "base string").is_equal (l_expected))
		end


	test_return_signature2
		local
			l_service : HMAC_SHA1_SIGNATURE_SERVICE
			l_expected: STRING
		do
			l_expected := "0anl6O7gtZfslLZ5j3QoTwd0uPY="
			create l_service
			assert("Expected:0anl6O7gtZfslLZ5j3QoTwd0uPY=", l_service.signature ("abc", "def", "foo").is_equal (l_expected))
		end
end
