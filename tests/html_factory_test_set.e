note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTML_FACTORY_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_basic_html_page_creation
			-- Test to prove a standard HTML page can be created.
		local
			l_html_factory: HTML_FACTORY
		do
			create l_html_factory
			assert_strings_equal ("html_page", most_basic_html_page_in_english, l_html_factory.html_page ("", "en"))
		end

feature {NONE} -- Implementation: Constants

	most_basic_html_page_in_english: STRING = "[
<!doctype html>
<html lang=en>
<\html>
]"

end


