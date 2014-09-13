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


end
