note
	description: "Summary description for {GITHUB_USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GITHUB_USER

create
	make_from_json_object,
	make_from_json

feature {NONE} -- Initialization

	make_from_json (s: READABLE_STRING_8)
		local
			p: JSON_PARSER
		do
			create p.make_parser (s)
			if attached {JSON_OBJECT} p.parse as j then
				make_from_json_object (j)
			end
		end

	make_from_json_object (j: JSON_OBJECT)
		local
			p: JSON_PARSER
		do
			if attached {JSON_NUMBER} j.item ("id") as js then
				id := js.item
			end
			if attached {JSON_STRING} j.item ("login") as js then
				login := js.item
			end
			if attached {JSON_STRING} j.item ("url") as js then
				url := js.item
			end
		end

feature -- Access

	id: detachable READABLE_STRING_8
	login: detachable READABLE_STRING_8
	url: detachable READABLE_STRING_8

end
