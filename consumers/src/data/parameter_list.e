note
	description: "Summary description for {PARAMETER_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_LIST

inherit

	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_parameters
feature {NONE} -- Initialization

	default_create
		do
			create {ARRAYED_LIST[PARAMETER]} parameters.make (5)
		end

	make_with_parameters  ( a_params : like parameters)
		do
			parameters := a_params
		end

	parameters: LIST [PARAMETER]

feature -- Add: parameter
	add_parameter ( key : READABLE_STRING_8; value : READABLE_STRING_8)
		local
			l_param : PARAMETER
		do
			create l_param.make (key, value)
			parameters.force (l_param)
		ensure
			one_more_element : old parameters.count + 1= parameters.count
		end
feature -- Access

	QUERY_STRING_SEPARATOR: STRING = "?"

	PARAM_SEPARATOR: STRING = "&"

	PAIR_SEPARATOR: STRING = "="

	EMPTY_STRING: STRING = ""

end
