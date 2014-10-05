note
	description: "[
		Test example W3 Schools <table>
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SAVINGS_TABLE

inherit
	HTML_TABLE

create
	make_with_data

feature {NONE} -- Initialize

	make_with_data (a_data: ARRAY [TUPLE [month_name, savings_amount: STRING]]; a_id: detachable STRING)
			-- Initialize Current with list of month names and savings amounts in `a_data' TUPLE and an optional `a_id'.
		require
			has_data: across a_data as ic_data all (not ic_data.item.month_name.is_empty) and (not ic_data.item.savings_amount.is_empty) end
			has_id: attached a_id as al_id implies not al_id.is_empty
		do
			if attached a_id as al_id and then not al_id.is_empty then
				make_with_id (al_id)
			end

				-- Create table, adding header and a row for each `a_data' item.
			add_content_item (header_row)
			across a_data as ic_data loop
				add_content_item (row (ic_data.item))
			end
		end

feature {NONE} -- Implementation

	header_row: HTML_TABLE_ROW
			-- Header of Current.
		local
			l_header: HTML_TABLE_HEADER
			l_text: HTML_TEXT
		once
				-- Set up standard headers
			create Result
			create l_header
			create l_text.make_with_text (month_header_text)
			l_header.add_content_item (l_text)
			Result.add_content_item (l_header)
			create l_text.make_with_text (savings_header_text)
			create l_header
			l_header.add_content_item (l_text)
			Result.add_content_item (l_header)
		end

	month_header_text: STRING = "Month"

	savings_header_text: STRING = "Savings"

	row (a_row_data: attached like internal_data_tuple_anchor): HTML_TABLE_ROW
			-- <tr> for Current.
		local
			l_data: HTML_TABLE_DATA
			l_text: HTML_TEXT
		do
				create Result
				create l_data
				create l_text.make_with_text (a_row_data.month_name)
				l_data.add_content_item (l_text)
				Result.add_content_item (l_data)
				create l_data
				create l_text.make_with_text (a_row_data.savings_amount)
				l_data.add_content_item (l_text)
				Result.add_content_item (l_data)
		end

	internal_data_tuple_anchor: detachable TUPLE [month_name, savings_amount: STRING]
			-- Type anchor for data row.

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
