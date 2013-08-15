note
	description: "Summary description for {HEADER_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_EXTRACTOR_10

inherit

	HEADER_EXTRACTOR

feature -- Extractor

	extract (request: OAUTH_REQUEST): READABLE_STRING_GENERAL
			-- Generates an OAuth 'Authorization' Http header to include in requests as the signature.
		require else
			has_oauth_parameters: not request.outh_parameters.is_empty
		local
			l_parameters : STRING_TABLE[STRING]
			header: STRING_32
			l_element : STRING_32
			l_encoder : OAUTH_ENCODER
		do
			l_parameters := request.outh_parameters
			create l_encoder
			create header.make (l_parameters.count * Estimated_param_length)
			header.append (Preamble)
			from
				l_parameters.start
			until
				l_parameters.after
			loop
				if header.count > Preamble.count then
					header.append (Param_separator)
				end
				create l_element.make_from_string (Header_template)
				l_element.replace_substring_all ("$KEY", l_parameters.key_for_iteration.as_string_8)
				l_element.replace_substring_all ("$VALUE", l_encoder.encoded_string (l_parameters.item_for_iteration.as_string_8))
				header.append (l_element)
				l_parameters.forth
			end
			Result := header
		end


feature {NONE} -- Implementation

	Param_separator: STRING = ", "

	Preamble: STRING = "OAuth "

	Estimated_param_length: INTEGER = 20

	Header_template: STRING = "$KEY=%"$VALUE%""

end
