note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTML_ELEMENT_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_empty_table
			-- Test <table></table>.
		local
			l_table: HTML_TABLE
			l_html: STRING
		do
			create l_table
			l_html := ""
			l_table.html (l_html)
			assert_strings_equal ("empty_table", empty_table, l_html)
		end

	test_table_and_tbody
			-- Test for <table><tbody></tbody></table>.
		local
			l_table: HTML_TABLE
			l_body: HTML_TABLE_BODY
			l_html: STRING
		do
			create l_table
			l_html := ""
			l_table.html (l_html)
			assert_strings_equal ("empty_table", empty_table, l_html)
			create l_body
			l_table.add_content_item (l_body)
			l_html := ""
			l_table.html (l_html)
			assert_strings_equal ("table_with_body", table_with_body, l_html)
		end

	test_table_with_all_subelements
			-- Test for <table> with all subelements: <th>, <tbody>, <tr>, and <td>.
		local
			l_table: HTML_TABLE
			l_header: HTML_TABLE_HEADER
			l_body: HTML_TABLE_BODY
			l_row: HTML_TABLE_ROW
			l_data: HTML_TABLE_DATA
			l_text: HTML_TEXT
			l_html: STRING
		do
			create l_table
			create l_header
			create l_body
			create l_row
			create l_data
			create l_text
			l_text.set_text ("text_to_render")
			l_table.add_content_item (l_header)
			l_table.add_content_item (l_body)
			l_body.add_content_item (l_row)
			l_row.add_content_item (l_data)
			l_data.add_content_item (l_text)
			l_html := ""
			l_table.html (l_html)
			assert_strings_equal ("table_with_subelements", table_with_subelements, l_html)
		end

feature {NONE} -- Implementation: Constants

	empty_table: STRING = "<table></table>"
			-- What an empty HTML-5 table looks like.

	table_with_body: STRING = "<table><tbody></tbody></table>"

	table_with_subelements: STRING = "<table><th></th><tbody><tr><td>text_to_render</td></tr></tbody></table>"

note
	copyright: "[
			Eiffel Forum License, version 2

			Permission is hereby granted to use, copy, modify and/or distribute
			this package, provided that: copyright notices are retained unchanged,
			any distribution of this package, whether modified or not, includes
			this license text.  Permission is hereby also granted to distribute
			binary programs which depend on this package. If the binary program
			depends on a modified version of this package, you are encouraged to
			publicly release the modified version of this package.
			***********************

			THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT WARRANTY. ANY EXPRESS OR
			IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
			WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
			DISCLAIMED. IN NO EVENT SHALL THE AUTHORS BE LIABLE TO ANY PARTY FOR
			ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
			DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THIS PACKAGE.
			***********************
		]"
end


