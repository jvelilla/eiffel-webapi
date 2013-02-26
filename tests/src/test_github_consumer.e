note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_GITHUB_CONSUMER

create
	make

feature {NONE} -- Initialization

	parameters: TEST_GITHUB_PARAMETERS

	make (p: like parameters)
			-- Initialize `Current'.
		require
			p_valid: p.is_valid
		do
			parameters := p
		end

feature -- Execution

	execute
		local
			p: like parameters
			github: GITHUB
			tok: detachable READABLE_STRING_8
		do
			p := parameters

			create github.make (p.username, p.password)

			github.get_authorizations
			across
				github.authorizations as c
			loop
				print (c.item.debug_output)
				print ("%N")
			end
			tok := p.token
			if tok = Void then
				if attached github.new_authorization_token (<<"user", "repo", "public_repo">>) as auth then
					tok := auth.token
				end
			end
			if tok /= Void then
				if tok /= p.token then
					p.set_token (tok)
					p.save
				end

				github.set_active_authorization (create {GITHUB_AUTHORIZATION}.make (tok))
				if attached github.repositories as repos then
					across
						repos as c
					loop
						print (c.item.debug_output)
						print ("%N")
					end
				end
			end

		end


--feature -- Execution

--	test
--		do
--			get_url ("/authorizations")
----			get_url ("/user")
----			get_url ("/user/repos")
----			get_url ("/user/repos?page=1&per_page=3")

----			get_url ("/")
----			get_url ("/gists")
--			post_url ("/gists", "{%"description%": %"Testing Eiffel, OAuth and Gist.github.com%", %"public%": true, %"files%": {%"test.txt%": {%"content%": %"This is a test%"}}}")
----			get_url ("/gists/59504")
--		end



end
