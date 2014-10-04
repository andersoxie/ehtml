note
	description: "[
		Test example W3 Schools <table>
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SAVINGS_TABLE

create
	make_with_data

feature {NONE} -- Initialize

	make_with_data (a_data: ARRAY [TUPLE [month_name, savings_amount: STRING]]; a_id: detachable STRING)
			-- Initialize Current with list of month names and savings amounts in `a_data' TUPLE and an optional `a_id'.
		local
			l_header: HTML_TABLE_HEADER
			l_row: HTML_TABLE_ROW
			l_data: HTML_TABLE_DATA
			l_text: HTML_TEXT
		do
			if attached a_id as al_id and then not al_id.is_empty then
				create table.make_with_id (al_id)
			else
				create table
			end
			check has_table: attached table end

				-- Set up standard headers
			create l_row
			create l_header
			create l_text.make_with_text (month_header_text)
			l_header.add_content_item (l_text)
			l_row.add_content_item (l_header)
			create l_text.make_with_text (savings_header_text)
			create l_header
			l_header.add_content_item (l_text)
			l_row.add_content_item (l_header)
			table.add_content_item (l_row)

			across a_data as ic_data loop
				create l_row
				create l_data
				create l_text.make_with_text (ic_data.item.month_name)
				l_data.add_content_item (l_text)
				l_row.add_content_item (l_data)
				create l_data
				create l_text.make_with_text (ic_data.item.savings_amount)
				l_data.add_content_item (l_text)
				l_row.add_content_item (l_data)
				table.add_content_item (l_row)
			end
		end

feature -- Access

	html: STRING
			-- HTML contents of Current.
		do
			create Result.make_empty
			table.html (Result)
		end

feature {NONE} -- Implementation

	table: HTML_TABLE
			-- Internal storage for wrapped <table>

	month_header_text: STRING = "Month"

	savings_header_text: STRING = "Savings"

;note
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
