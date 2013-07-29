note
	description: "Objects that represent an OAUTH REQUEST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_REQUEST
create
	make
feature {NONE} -- Initialization
	make (http_method : STRING; url : STRING )
		do
			create parameters.make (0)
		end
feature -- Access
	parameters : STRING_TABLE [STRING]

	is_valid_key (key : STRING) : BOOLEAN
			-- is the key a valid Oauth key parameter?
		do
			if key.starts_with (oauth_prefix) or else key.same_string (({OAUTH_CONSTANTS}.scope)) then
				Result := True
			else
				--OAuth parameters must start with `oauht' or it should be `scope'
				--| we need logging or report this as an ERROR
			end
		end
feature -- Add Parameters
	add_parameter (key : STRING; value : STRING)
			-- Add an OAuth parameter with value `value' and key `key'
		require
			-- valid_key
		do
			parameters.force (value, key)
		ensure
			parameter_added : parameters.has (key)
		end

feature {NONE} -- Implementation

	Oauth_prefix : STRING = "oauth_"


end
