note
	description: "[
		HTML Constants
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONSTANTS

feature -- Constants

	uppercase_a_to_z: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			-- Uppercase A-Z

	lowercase_a_to_z: STRING = "abcdefghijklmnopqrstuvwxyz"
			-- Lowercase a-z

	numeric_digits: STRING = "0123456789"
			-- Numeric digits 0-9

	special_characters: STRING = "-_"
			-- Miscellaneous special characters.

feature -- Constants: Named Boolean Operators

	is_double_quoted: BOOLEAN = True
			-- When something must be wrapped in double-quotes.

end
