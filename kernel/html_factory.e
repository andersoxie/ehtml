note
	description: "[
		Representation of an HTML Factory
		]"
	how: "[
		By a supply of start-and-end tags, which are appended, where appending is
		the fastest and most efficient way to build strings.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FACTORY

feature -- Access

	html_page (a_body, a_language_code: STRING): STRING
			-- HTML Page	
		do
			Result := tag_with_contents ("!doctype", "html", no_tag_content, no_global_attributes, False, False)
			if not a_language_code.is_empty then
				Result.append_string (tag_with_contents (html_tag, "lang=" + a_language_code, no_tag_content, no_global_attributes, True, False))
			else
				Result.append_string (tag_with_contents (html_tag, no_manaul_attributes, no_tag_content, no_global_attributes, True, False))
			end
		end

	html_tag: STRING = "html"

feature -- Basic Operations

	tag_with_contents (a_tag: STRING; a_manual_attributes, a_contents: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_has_end_tag, a_is_self_ending: BOOLEAN): STRING
			-- Start and End tags with `a_contents' between.
		note
			purpose: "[
				To build an HTML `a_tag' completely, with Start-and-End tags, including attributes
				(both those that are by specification and any manual or corner-case attributes) and
				also including any content between the tags.
				]"
		do
			Result := start_tag (a_tag, a_manual_attributes, a_attributes, a_is_self_ending)
			Result.append_string (a_contents)
			if a_has_end_tag then
				Result.append_string (end_tag (a_tag))
			end
		end

	start_tag (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_is_self_ending: BOOLEAN): STRING
			-- Start tag based on `a_tag'.
		local
			l_attributes: STRING
		do
			if attached a_attributes as al_attributes then
				l_attributes := al_attributes.attributes.twin
				l_attributes.append_character (space)
				l_attributes.append_string (a_manual_attributes)
			else
				if attached a_manual_attributes as al_manual_attributes then
					create l_attributes.make_from_string (al_manual_attributes)
				else
					create l_attributes.make_empty
				end
			end
			create Result.make (a_tag.count + 2 + l_attributes.count)
			Result.append_character (left_angle)
			Result.append_string (a_tag)
			Result.append_character (space)
			Result.append_string (l_attributes)
			if a_is_self_ending then
				Result.append_character (end_slash)
			end
			Result.append_character (right_angle)
			Result.append_character (new_line)
		end

	end_tag (a_tag: STRING): STRING
			-- End tag based on `a_tag'.
		do
			create Result.make (a_tag.count + 3)
			Result.append_character (left_angle)
			Result.append_character (end_slash)
			Result.append_string (a_tag)
			Result.append_character (right_angle)
		end

feature {NONE} -- Implementation: Constants

	left_angle: CHARACTER_8 = '<'
	right_angle: CHARACTER_8 = '>'
	end_slash: CHARACTER_8 = '\'
	space: CHARACTER_8 = ' '
	new_line: CHARACTER_8 = '%N'

	no_manaul_attributes: detachable STRING
			-- Constants used to indicate how there are no manually determined attributes for the tag under construction.

	no_tag_content: detachable STRING
			-- Constants used to indicate how there are no contents for the tag under construction.

	no_global_attributes: detachable HTML_GLOBAL_ATTRIBUTES
			-- Constants used to indicate how there are no global attributes for the tag under construction.

end
