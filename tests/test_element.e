note
	description: "[
		Representation of an HTML Element for testing purposes.
		]"
	how: "[
		By providing a generic (unspecified) element, representing all elements with
			global attributes and then using Current to test notions found in the
			HTML_GLOBAL_ELEMENTs and others (as required).
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ELEMENT

inherit
	HTML_GLOBAL_ATTRIBUTES
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			Precursor
			create inline_style
		end

end
