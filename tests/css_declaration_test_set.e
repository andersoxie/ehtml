note
	description: "[
		CSS Declaration testing
	]"
	author: "Larry Rix"
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
			assert_strings_equal ("margin_4", "margin-top:1px; margin-bottom:2px; margin-left:3px; margin-right:4px;", l_decl.string)
				-- All zero
			create l_decl.make ([[0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("margin_4", "margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px;", l_decl.string)
				-- All negative
			create l_decl.make ([[-1, {CSS_LENGTH_CONSTANTS}.px], [-2, {CSS_LENGTH_CONSTANTS}.px], [-3, {CSS_LENGTH_CONSTANTS}.px], [-4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("margin_4", "margin-top:-1px; margin-bottom:-2px; margin-left:-3px; margin-right:-4px;", l_decl.string)

				-- Use the 'all' short-hand for short-hand result.
			create l_decl.make_shorthand_all (25, 50, 75, 100, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_all", "margin 25px 50px 75px 100px;", l_decl.string)
				-- All short-hand zero
			create l_decl.make_shorthand_all (0, 0, 0, 0, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_all_zero", "margin 0px 0px 0px 0px;", l_decl.string)
				-- All short-hand negative
			create l_decl.make_shorthand_all (-25, -50, -75, -100, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_all_negative", "margin -25px -50px -75px -100px;", l_decl.string)

				-- Use the top [left-right] bottom version for short-hand result.
			create l_decl.make_shorthand_t_lr_b (25, 50, 75, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_t_lr_b", "margin 25px 50px 75px;", l_decl.string)

				-- Use the top-bottom and left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tb_lr (25, 50, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_tb_lr", "margin 25px 50px;", l_decl.string)

				-- Use the top-bottom-left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tblr (25, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("margin_tblr", "margin 25px;", l_decl.string)

				-- % Test.
			create l_decl.make_shorthand_tblr (25, {CSS_LENGTH_CONSTANTS}.percent)
			assert_strings_equal ("margin_tblr", "margin 25%%;", l_decl.string)

				-- Make a non-short-hand result of just top and right.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [0, Void], [4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("margin_t_r", "margin-top:1px; margin-right:4px;", l_decl.string)

				-- Make a non-short-hand result of just top and left.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [3, {CSS_LENGTH_CONSTANTS}.px], [0, Void]])
			assert_strings_equal ("margin_t_r", "margin-top:1px; margin-left:3px;", l_decl.string)

		end

	test_css_declaration_padding
			-- Test of CSS "padding"
		local
			l_decl: CSS_PADDING
		do
				-- Set all four manually (through make), but expect the short-hand result.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [2, {CSS_LENGTH_CONSTANTS}.px], [3, {CSS_LENGTH_CONSTANTS}.px], [4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("padding_4", "padding-top:1px; padding-bottom:2px; padding-left:3px; padding-right:4px;", l_decl.string)
				-- All zero
			create l_decl.make ([[0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px], [0, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("padding_4", "padding-top:0px; padding-bottom:0px; padding-left:0px; padding-right:0px;", l_decl.string)
				-- All negative
			create l_decl.make ([[-1, {CSS_LENGTH_CONSTANTS}.px], [-2, {CSS_LENGTH_CONSTANTS}.px], [-3, {CSS_LENGTH_CONSTANTS}.px], [-4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("padding_4", "padding-top:-1px; padding-bottom:-2px; padding-left:-3px; padding-right:-4px;", l_decl.string)

				-- Use the 'all' short-hand for short-hand result.
			create l_decl.make_shorthand_all (25, 50, 75, 100, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_all", "padding 25px 50px 75px 100px;", l_decl.string)
				-- All short-hand zero
			create l_decl.make_shorthand_all (0, 0, 0, 0, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_all_zero", "padding 0px 0px 0px 0px;", l_decl.string)
				-- All short-hand negative
			create l_decl.make_shorthand_all (-25, -50, -75, -100, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_all_negative", "padding -25px -50px -75px -100px;", l_decl.string)

				-- Use the top [left-right] bottom version for short-hand result.
			create l_decl.make_shorthand_t_lr_b (25, 50, 75, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_t_lr_b", "padding 25px 50px 75px;", l_decl.string)

				-- Use the top-bottom and left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tb_lr (25, 50, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_tb_lr", "padding 25px 50px;", l_decl.string)

				-- Use the top-bottom-left-right short-hand for short-hand result.
			create l_decl.make_shorthand_tblr (25, {CSS_LENGTH_CONSTANTS}.px)
			assert_strings_equal ("padding_tblr", "padding 25px;", l_decl.string)

				-- % Test.
			create l_decl.make_shorthand_tblr (25, {CSS_LENGTH_CONSTANTS}.percent)
			assert_strings_equal ("padding_tblr", "padding 25%%;", l_decl.string)

				-- Make a non-short-hand result of just top and right.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [0, Void], [4, {CSS_LENGTH_CONSTANTS}.px]])
			assert_strings_equal ("padding_t_r", "padding-top:1px; padding-right:4px;", l_decl.string)

				-- Make a non-short-hand result of just top and left.
			create l_decl.make ([[1, {CSS_LENGTH_CONSTANTS}.px], [0, Void], [3, {CSS_LENGTH_CONSTANTS}.px], [0, Void]])
			assert_strings_equal ("padding_t_r", "padding-top:1px; padding-left:3px;", l_decl.string)

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


