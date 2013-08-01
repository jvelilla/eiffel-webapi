note
	description: "Summary description for {BASE_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_REQUEST

inherit

	HTTP_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_method: READABLE_STRING_GENERAL; a_uri: READABLE_STRING_GENERAL)
		require
			valid_http_method: is_http_method (a_method)
		do
			verb := a_method
			uri := a_uri
			create query_string_parameters.default_create
			create body_parameters.default_create
			create headers.make (5)
		ensure
			ver_set: verb = a_method
			uri_set: uri = a_uri
		end

feature -- Status Report

	is_http_method (a_method: READABLE_STRING_GENERAL): BOOLEAN
		do
			if a_method.same_string (method_connect) then
				Result := True
			elseif a_method.same_string (method_delete) then
				Result := True
			elseif a_method.same_string (method_get) then
				Result := True
			elseif a_method.same_string (method_head) then
				Result := True
			elseif a_method.same_string (method_options) then
				Result := True
			elseif a_method.same_string (method_patch) then
				Result := True
			elseif a_method.same_string (method_post) then
				Result := True
			elseif a_method.same_string (method_put) then
				Result := True
			elseif a_method.same_string (method_trace) then
				Result := True
			end
		end

feature -- Constants

	CONTENT_LENGTH: STRING_32 = "Content-Length";

	CONTENT_TYPE: STRING_32 = "Content-Type";

	DEFAULT_CONTENT_TYPE: STRING
		once
			Result := application_x_www_form_encoded
		end

feature -- Access

	uri: READABLE_STRING_GENERAL

	verb: READABLE_STRING_GENERAL

	query_string_parameters: PARAMETER_LIST

	body_parameters: PARAMETER_LIST

	headers: STRING_TABLE [STRING]

	payload: detachable STRING

	executor : detachable REQUEST_EXECUTOR

feature -- Execute
	execute : detachable OAUTH_RESPONSE
		do
			initialize_executor
			Result := do_execute
		end

	initialize_executor
		do
			create executor.make (query_string_parameters.append_to (uri).as_string_32,verb)
		end

feature {NONE} -- Implementation
	do_execute : detachable OAUTH_RESPONSE
		do
			if attached executor as l_executor then
				-- add headers
				add_headers (l_executor)
				if verb.same_string (method_put) or else verb.same_string (method_post) then
					l_executor.set_body (body_contents.as_string_8)
				end
				if not l_executor.context_executor.headers.has (content_type) then
					l_executor.context_executor.add_header (content_type, default_content_type)
				end
				if attached l_executor.execute as l_response then
					create Result.make (l_response)
				end
			end
		end


feature {NONE} -- Implementation
	add_headers (a_executor : REQUEST_EXECUTOR)
		do
				from headers.start
				until
					headers.after
				loop
					a_executor.context_executor.add_header (headers.key_for_iteration.as_string_32,headers.item_for_iteration.as_string_32)
					headers.forth
				end
		end


	body_contents : READABLE_STRING_GENERAL
		do
			if attached payload as l_payload then
				Result := l_payload
			else
				Result := body_parameters.as_form_url_encoded_string
			end
		end

end
