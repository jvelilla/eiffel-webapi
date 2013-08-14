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
		do
			l_expected := "uGymw2KHOTWI699YEaoi5xyLT50"
			create l_service
			assert("Expected:uGymw2KHOTWI699YEaoi5xyLT50==", l_service.signature ("api secret", "token secret", "base string").is_equal (l_expected))
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
