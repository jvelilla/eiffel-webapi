note
	description: "Summary description for {TEST_PARAMETER_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PARAMETER_LIST

inherit

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature --Setup

	on_prepare
		do
			create parameters
		end

feature -- Tests

	should_not_append_to_query_string_with_empty_map()
 		local
 			l_uri : STRING
 		do
 			l_uri := "http://www.eiffelroom.com"
 			assert("Expected same string",l_uri.same_string (parameters.append_to (l_uri.as_string_32).as_string_32))
 		end

	should_append_parameters_to_simple_url
		local
	 			l_uri,l_uri_expected : STRING_32
	 		do
	 		  l_uri := "http://www.example.com"
   			  l_uri_expected := "http://www.example.com?param1=value1&param2=value%%20with%%20spaces"
			  l_uri_expected.trim

   			  parameters.add_parameter ("param1", "value1")
   			  parameters.add_parameter ("param2", "value with spaces")

			  l_uri := parameters.append_to (l_uri).as_string_32
  			  assert("Expected same uri", l_uri.same_string (l_uri_expected))
	 		end
feature {NONE} -- Implementation

	parameters: PARAMETER_LIST

end
