note
	description: "Summary description for {STRING_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_EXTRACTOR_10

inherit

	BASE_STRING_EXTRACTOR

feature -- Extractor

	extract (a_request: OAUTH_REQUEST): STRING_32
			-- Extract an url-encoded base string from the `a_request'
		do
		end


feature {NONE}-- Implementation
	 Ampersand_separated_string: STRING = "$VERB&$url&$PARAM";

end
