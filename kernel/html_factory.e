note
	description: "[
		Representation of an HTML Factory
		]"
	how: "[
		By a supply of start-and-end tags, which are appended, where appending is
		the fastest and most efficient way to build strings.
		]"
	todos: "[
		1. Instead of just `tag_with_content', do simpler variants like:
			a. `tag_inline_without_content'
			b. `tag_inline_no_end'
			c. `tag_inline_with_end'
			d. ... etc
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FACTORY

inherit
	HTML_GLOBAL_ATTRIBUTES

feature -- Access

	html_page (a_body, a_language_code: STRING): STRING
			-- HTML Page	
		do
			Result := tag_with_contents ("!doctype", "html", no_tag_content, no_global_attributes, False, False, False)
			if not a_language_code.is_empty then
				Result.append_string (tag_with_contents (html_tag, "lang=" + a_language_code, no_tag_content, no_global_attributes, True, False, False))
			else
				Result.append_string (tag_with_contents (html_tag, no_manaul_attributes, no_tag_content, no_global_attributes, True, False, False))
			end
		end

	html_tag: STRING = "html"

feature -- Basic Operations

	build_content_as_indented_newlines (a_items: ARRAY [STRING]): STRING
			-- Build Result content as indented lines from `a_items'.
		do
			create Result.make_empty
			across a_items as ic_items loop
				Result.append_string (indent_one_level_and_then_newline (ic_items.item))
			end
		ensure
			has_all_items: across a_items as ic_items all Result.has_substring (ic_items.item) end
		end

	indent_one_level_and_then_newline (a_item: STRING): STRING
			-- Indent `a_item' one level (i.e. TAB in one) and then append a newline char.
		require
			has_item: not a_item.is_empty
		do
			Result := indent_to_level (a_item, 1)
			Result.append_character (newline)
		ensure
			has_item: Result.has_substring (a_item)
			last_is_newline: Result [Result.count] = newline
		end

	indent_to_level (a_item: STRING; a_tab_count: INTEGER): STRING
			-- Indent `a_item' `a_tab_level' levels (i.e. TAB in `n' number of times).
		do
			Result := a_item
			across 1 |..| a_tab_count as ic_counter loop
				Result.prepend_character (tab)
			end
		ensure
			has_tab_count: Result.occurrences (tab) = a_tab_count
		end

	tag_with_contents (a_tag: STRING; a_manual_attributes, a_contents: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_has_end_tag, a_is_self_ending, a_suppress_newlines: BOOLEAN): STRING
			-- Start and End tags with `a_contents' between.
		note
			purpose: "[
				To build an HTML `a_tag' completely, with Start-and-End tags, including attributes
				(both those that are by specification and any manual or corner-case attributes) and
				also including any content between the tags.
				]"
		do
			Result := start_tag (a_tag, a_manual_attributes, a_attributes, a_is_self_ending, a_suppress_newlines)
			Result.append_string (a_contents)
			if a_has_end_tag then
				Result.append_string (end_tag (a_tag))
			end
		end

	start_tag (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_is_self_ending, a_suppress_newlines: BOOLEAN): STRING
			-- Start tag based on `a_tag'.
		local
			l_result,
			l_attributes: STRING
		do
			if attached a_attributes as al_attributes then
				create l_result.make_empty
				if attached a_manual_attributes as al_manual_attributes and then not al_manual_attributes.is_empty then
					l_result.append_character (space)
					l_result.append_string (al_manual_attributes)
				end
				l_attributes := al_attributes.attributes_with_all_data.twin
				if not l_attributes.is_empty then
					l_result.append_string (l_attributes)
				end
				l_attributes := l_result
			else
				if attached a_manual_attributes as al_manual_attributes then
					create l_attributes.make_from_string (al_manual_attributes)
					l_attributes.prepend_character (space)
				else
					create l_attributes.make_empty
				end
			end
			create Result.make (a_tag.count + 2 + l_attributes.count)
			Result.append_character (left_angle)
			Result.append_string (a_tag)
			Result.append_string (l_attributes)
			if a_is_self_ending then
				Result.append_character (end_slash)
			end
			Result.append_character (right_angle)
			if not a_suppress_newlines then
				Result.append_character (newline)
			end
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
	newline: CHARACTER_8 = '%N'
	tab: CHARACTER_8 = '%T'

	no_manaul_attributes: detachable STRING
			-- Constants used to indicate how there are no manually determined attributes for the tag under construction.

	no_tag_content: detachable STRING
			-- Constants used to indicate how there are no contents for the tag under construction.

	no_global_attributes: detachable HTML_GLOBAL_ATTRIBUTES
			-- Constants used to indicate how there are no global attributes for the tag under construction.

end
