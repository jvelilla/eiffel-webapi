note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			prepare

			test_github
			test_google
--			test_twitter -- NOT WORKING
		end

	prepare
		local
			e: EXECUTION_ENVIRONMENT
			d: DIRECTORY
		do
			create d.make ("data")
			if not d.exists then
				d.recursive_create_dir
			end
			create e
			e.change_working_directory (d.name)
		end

	test_github
		local
			p: TEST_GITHUB_PARAMETERS
			t: TEST_GITHUB_CONSUMER
		do
			create p
			create t.make (p)
			t.execute
		end

	test_twitter
		local
			t: TEST_TWITTER_CONSUMER
			p: TEST_TWITTER_PARAMETERS
		do
			create p
			create t.make (p.username, p.password, p.consumer_key, p.consumer_secret)
			t.execute
		end

	test_google
		local
			t: TEST_GOOGLE_CONSUMER
			p: TEST_GOOGLE_PARAMETERS
		do
			create p
			create t.make (p)
			t.execute
		end

end
