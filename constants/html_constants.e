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

	space_8: CHARACTER_8 = ' '
			-- 8-bit space.

feature -- Constants: Named Boolean Operators

	is_double_quoted: BOOLEAN = True
			-- When something must be wrapped in double-quotes.

	left_angle: CHARACTER_8 = '<'
	right_angle: CHARACTER_8 = '>'
	end_slash: CHARACTER_8 = '/'
	space: CHARACTER_8 = ' '
	newline: CHARACTER_8 = '%N'
	tab: CHARACTER_8 = '%T'

	english_code: STRING = "en"

	no_body: STRING = ""

	no_content: detachable STRING

	no_manual_attributes: detachable STRING

	has_end_tag: BOOLEAN = True

	is_self_ending: BOOLEAN = True

	suppress_newlines: BOOLEAN = True

	no_manaul_attributes: detachable STRING
			-- Constants used to indicate how there are no manually determined attributes for the tag under construction.

	no_tag_content: detachable STRING
			-- Constants used to indicate how there are no contents for the tag under construction.

	no_global_attributes: detachable HTML_GLOBAL_ATTRIBUTES
			-- Constants used to indicate how there are no global attributes for the tag under construction.

	yes: BOOLEAN = True

	no: BOOLEAN
		do
			Result := not yes
		end

feature -- Constants: Tag names

	get_method_name: STRING = "GET"

	post_method_name: STRING = "POST"

	html_tag_name: STRING = "html"

	body_tag_name: STRING = "body"

	form_tag_name: STRING = "form"

	input_tag_name: STRING = "input"

	paragraph_tag_name: STRING = "p"

	head_tag_name: STRING = "head"

	title_tag_name: STRING = "title"

	op_parameter_keyword: STRING = "op"
			-- Keyword for "op" (operation) parameter.

	quit_operation_keyword: STRING = "quit"
			-- Keyword for "quit" parameter.

end
