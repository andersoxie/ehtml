note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GLOBAL_ATTRIBUTES_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_global_attributes
			-- Test creation and modification of global attributes.
		local
			l_test: TEST_ELEMENT
		do
			create l_test									-- Test of creation and post-creation invariant.
			l_test.set_class_attribute_value ("Test_Class-1")	-- Test of invariant, post-setting of "class" attribute.
		end

end


