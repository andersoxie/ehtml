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
			l_table.append_html (l_html)
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
			l_table.append_html (l_html)
			assert_strings_equal ("empty_table", empty_table, l_html)
			create l_body
			l_table.add_content_item (l_body)
			l_html := ""
			l_table.append_html (l_html)
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
			create l_text.make_with_text ("text_to_render")
			l_table.add_content_item (l_header)
			l_table.add_content_item (l_body)
			l_body.add_content_item (l_row)
			l_row.add_content_item (l_data)
			l_data.add_content_item (l_text)
			l_html := ""
			l_table.append_html (l_html)
			assert_strings_equal ("table_with_subelements", table_with_subelements, l_html)
		end

	text_w3schools_sample_table
			-- Test of the W3 Schools <table> sample.
		note
			EIS: "name=table_sample", "src=http://www.w3schools.com/tags/tryit.asp?filename=tryhtml_table_test", "protocol=URI", "tag=w3schools"
		local
			l_table: HTML_TABLE
			l_header: HTML_TABLE_HEADER
			l_row: HTML_TABLE_ROW
			l_data: HTML_TABLE_DATA
			l_text: HTML_TEXT
			l_html: STRING
		do
			create l_table
			create l_row
			create l_header
			create l_text.make_with_text ("Month")
			l_header.add_content_item (l_text)
			l_row.add_content_item (l_header)
			create l_text.make_with_text ("Savings")
			create l_header
			l_header.add_content_item (l_text)
			l_row.add_content_item (l_header)
			l_table.add_content_item (l_row)

			create l_row
			create l_data
			create l_text.make_with_text ("January")
			l_data.add_content_item (l_text)
			l_row.add_content_item (l_data)
			create l_data
			create l_text.make_with_text ("$100")
			l_data.add_content_item (l_text)
			l_row.add_content_item (l_data)
			l_table.add_content_item (l_row)

			create l_row
			create l_data
			create l_text.make_with_text ("February")
			l_data.add_content_item (l_text)
			l_row.add_content_item (l_data)
			create l_data
			create l_text.make_with_text ("$80")
			l_data.add_content_item (l_text)
			l_row.add_content_item (l_data)
			l_table.add_content_item (l_row)

			l_html := ""
			l_table.append_html (l_html)
			assert_strings_equal ("w3schools_table_sample", w3schools_table_sample, l_html)

		end

	test_test_table_version
			-- Same as `text_w3schools_sample_table' test, but with a class instead of building by hand.
		note
			how: "[
				By testing the results of the TEST_SAVINGS_TABLE class `append_html' output with the sample constant
				and then saving that as a full-HTML version to the `docs\test_outputs' folder where it can be
				examined in a browser.
				]"
		local
			l_test_table: TEST_SAVINGS_TABLE
			l_page: HTML_PAGE
			l_body: HTML_BODY
			l_html, l_final: STRING
			l_file: PLAIN_TEXT_FILE
		do
				-- Sample for in-memory testing
			create l_test_table.make_with_data (<<["January", "$100"], ["February", "$80"]>>, Void)
			create l_html.make_empty
			l_test_table.append_html (l_html)
			assert_strings_equal ("w3schools_table_sample", w3schools_table_sample, l_html)

				-- Sample output to docs\test_output
			create l_file.make_create_read_write (".\docs\test_outputs\sample_table.html")
			l_final := w3schools_table_sample_full.twin
			l_final.replace_substring_all ("<<TABLE_SNIPPET>>", l_html)
			l_file.put_string (l_final)
			l_file.close

				-- Sample with 12 months
			create l_test_table.make_with_data (<<["January", "$100"], ["February", "$80"], ["March", "$80"], ["April", "$99"], ["May", "$75"], ["June", "$150"], ["July", "$50"], ["August", "$90"], ["September", "$130"], ["October", "$120"], ["November", "$100"], ["December", "$80"]>>, Void)
			create l_file.make_create_read_write (".\docs\test_outputs\sample_table_year.html")
			create l_page
			create l_body
			l_body.add_content_item (l_test_table)
			l_page.add_content_item (l_body)
			create l_final.make_empty
			l_page.append_html (l_final)
			l_file.put_string (l_final)
			l_file.close
		end

feature {NONE} -- Implementation: Constants

	empty_table: STRING = "<table></table>"
			-- What an empty HTML-5 table looks like.

	table_with_body: STRING = "<table><tbody></tbody></table>"

	table_with_subelements: STRING = "<table><th></th><tbody><tr><td>text_to_render</td></tr></tbody></table>"

	w3schools_table_sample: STRING = "<table><tr><th>Month</th><th>Savings</th></tr><tr><td>January</td><td>$100</td></tr><tr><td>February</td><td>$80</td></tr></table>"
	w3schools_table_sample_full: STRING = "<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black} th {color: red} td {color: blue}</style></head><body><<TABLE_SNIPPET>></body></html>"
		-- Both a <table> only version and a full HTML document version.

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


