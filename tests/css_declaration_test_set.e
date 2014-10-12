note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CSS_DECLARATION_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_css_declaration_margin
			-- Test of CSS "margin"
		local
			l_decl: CSS_MARGIN
		do
				-- Set all four manually (through make), but expect the short-hand result.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [2, {CSS_LENGTH_CONSTANTS}.px], [3, {CSS_LENGTH_CONSTANTS}.px], [4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("margin_4", "margin 1px 2px 3px 4px;", l_decl.string)

				-- Use the 'all' short-hand for short-hand result.
			create l_decl.make_shorthand_all (1, 2, 3, 4, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_all", "margin 1px 2px 3px 4px;", l_decl.string)

				-- Use the top [left-right] bottom version for short-hand result.
			create l_decl.make_shorthand_t_lr_b (1, 34, 2, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_t_lr_b", "margin 1px 34px 2px;", l_decl.string)

				-- Use the top-bottom and left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tb_lr (12, 34, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_tb_lr", "margin 12px 34px;", l_decl.string)

				-- Use the top-bottom-left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tblr (1234, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_tblr", "margin 1234px;", l_decl.string)

				-- Make a non-short-hand result of just top and right.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [0, Void], [4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("margin_t_r", "margin-top:1px; margin-right:4px;", l_decl.string)

				-- Make a non-short-hand result of just top and left.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [3, {CSS_LENGTH_CONSTANTS}.px], [0, Void]])
			assert_strings_equal ("margin_t_r", "margin-top:1px; margin-left:3px;", l_decl.string)

		end

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


