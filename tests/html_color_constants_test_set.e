note	
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTML_COLOR_CONSTANTS_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Tests

	test_colors
			-- Tests for the HTML_COLOR_CONSTANTS
		local
			l_constants: HTML_COLOR_CONSTANTS
		do
			create l_constants
			assert_strings_equal ("burlywood_name", "BurlyWood", l_constants.burlywood)
			assert_strings_equal ("YellowGreen_name", "YellowGreen", l_constants.yellowgreen)
			assert_equals ("rgb_values_burlywood", [222, 184, 135], l_constants.rgb_for_name (l_constants.burlywood))
			assert_equals ("rgb_values_yellowgreen", [154, 205, 50], l_constants.rgb_for_name (l_constants.yellowgreen))
		end

feature {NONE} -- Test Support


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
