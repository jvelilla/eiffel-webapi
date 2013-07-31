note
	description: "Summary description for {REQUEST_EXECUTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REQUEST_EXECUTOR
	inherit
	HTTP_CLIENT_HELPER
create
	make
feature {NONE} -- Initialization
	make (a_url: like base_url; a_method : READABLE_STRING_GENERAL)
		do
			set_base_url (a_url)
			method := a_method
		ensure
			base_url_set : base_url = a_url
			method_set : method = a_method
		end


	set_base_url (a_url : like base_url)
		do
			base_url := a_url
		end

feature -- Access		
	method : READABLE_STRING_GENERAL
		-- HTTP METHOD (Get, Post, ...)


end
