note
	description: "[
		Representation of an HTML Factory
		]"
	purpose: "[
		To provide a resource for generation of HTML tags and other asundry bits
		by operational EWF web sites and provided in such a way as to minimize
		the amount of object creation and computation required for generation.
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

inherit
	HTML_GLOBAL_ATTRIBUTES

feature -- Access

	html_page (a_content, a_language_code, a_doctype_attributes: detachable STRING): STRING
			-- <!doctype lang=[a_language_code]/> %N <html> %N [a_body] %N </html>
		require
			valid_lang_code: attached a_language_code implies language_codes.has (a_language_code)
		local
			l_doctype,
			l_html: STRING
		do
			Result := "<!doctype "
			if attached a_doctype_attributes then
				Result.append_string (a_doctype_attributes)
			end
			Result.append_character ('>')
			Result.append_character ('%N')
			if attached a_language_code and then not a_language_code.is_empty then
				l_html := tag_contented (Html_tag_name, tag_attribute ("lang", a_language_code), a_content, no_global_attributes, has_end_tag, not suppress_newlines)
			else
				l_html := tag_contented (Html_tag_name, no_manaul_attributes, a_content, no_global_attributes, has_end_tag, not suppress_newlines)
			end
			check valid_html: html_regex.matches (l_html) end
			Result.append_string (l_html)
		ensure
			has_doctype_attributes: attached a_doctype_attributes as al_attributes implies Result.has_substring (al_attributes)
			has_lang_code: attached a_language_code as al_code implies Result.has_substring ("lang=" + al_code)
		end

feature -- Access: <form> ... </form>

	form (a_content: STRING; a_manual_attributes: detachable STRING): STRING
			-- <form [a_manual_attributes]> %N [a_content] %N </form>
		do
			Result := tag_contented_no_global_attributes (form_tag_name, a_manual_attributes, a_content)
		ensure
			valid_form: form_regex.matches (Result)
			has_content: attached a_content as al_content implies Result.has_substring (al_content)
		end

	input_text_field (a_name_attribute: STRING): STRING
			-- <input type="text" name="[a_name_attribute]"/>
		do
			Result := tag_no_content_self_ending (input_tag_name, tag_attribute_quoted_value ("type", "text") + " " + tag_attribute_quoted_value ("name", a_name_attribute), no_global_attributes)
		ensure
			valid_input_text: input_regex.matches (Result)
		end

	submit_button (a_button_caption: STRING): STRING
			-- <input type="submit" value="[a_button_caption]/>"
		do
			Result := tag_no_content_self_ending (input_tag_name, tag_attribute_quoted_value ("type", "submit") + " " + tag_attribute_quoted_value ("value", a_button_caption), no_global_attributes)
		ensure
			valid_input_text: input_regex.matches (Result)
		end

feature -- Access: <head> ... </head>

	head (a_content: STRING): STRING
			-- <head> [a_content] </head>
		do
			Result := tag_contented (head_tag_name, Void, indent_one_level_and_then_newline (a_content), no_global_attributes, has_end_tag, not suppress_newlines)
		ensure
			valid_head: head_regex.matches (Result)
		end

feature -- Access: <title> ... </title>

	title (a_content: STRING): STRING
			-- <title> [a_content] </title>
		do
			Result := tag_contented (title_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
		ensure
			valid_title: title_regex.matches (Result)
		end

feature -- Access: <p> ... </p>

	paragraph (a_content: STRING): STRING
			-- <p> [a_content] </p>
		do
			Result := tag_contented (paragraph_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
		ensure
			valid_paragrah: paragraph_regex.matches (Result)
		end

feature -- Access: <[tag]> ... </[tag]> w/Content

	tag_contented_no_global_attributes (a_tag: STRING; a_manual_attributes: detachable STRING; a_content: STRING): STRING
			-- <[a_tag] [a_manual_attributes]> [a_content] </[a_tag]>, but with `no_global_attributes'
		do
			Result := tag_contented (a_tag, a_manual_attributes, a_content, no_global_attributes, has_end_tag, not suppress_newlines)
		end

	tag_contented (a_tag: STRING; a_manual_attributes, a_contents: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_has_end_tag, a_suppress_newlines: BOOLEAN): STRING
			--  <[a_tag] [a_manual_attributes]> [a_content] </[a_tag]>
		note
			purpose: "[
				To build an HTML `a_tag' completely, with Start-and-End tags, including attributes
				(both those that are by specification and any manual or corner-case attributes) and
				also including any content between the tags.
				]"
		do
			Result := start_tag (a_tag, a_manual_attributes, a_attributes, not a_has_end_tag, a_suppress_newlines)
			Result.append_string (a_contents)
			if a_has_end_tag then
				Result.append_string (end_tag (a_tag))
			end
		ensure
			valid_start_end: a_has_end_tag implies (start_end_tag_regex (a_tag)).matches (Result)
		end

feature -- Access: <[tag]> ... </[tag]> w/o-Content

	tag_no_content (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES): STRING
			-- ???
		do
			Result := tag_contented (a_tag, a_manual_attributes, Void, Void, has_end_tag, not suppress_newlines)
		end

	tag_no_content_inline (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES): STRING
			-- ???
		do
			Result := tag_contented (a_tag, a_manual_attributes, Void, Void, has_end_tag, suppress_newlines)
		end

	tag_no_content_self_ending (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES): STRING
			-- ???
		do
			Result := tag_contented (a_tag, a_manual_attributes, Void, Void, not has_end_tag, suppress_newlines)
		end

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
			has_tab_count: Result.occurrences (tab) >= a_tab_count
		end

feature {NONE} -- Implementation: Tag Primitives

	frozen start_tag (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_is_self_ending, a_suppress_newlines: BOOLEAN): STRING
			-- Start tag based on `a_tag'.
		local
			l_result,
			l_attributes: STRING
		do
			if attached a_attributes then
				create l_result.make_empty
				if attached a_manual_attributes and then not a_manual_attributes.is_empty then
					l_result.append_character (space)
					l_result.append_string (a_manual_attributes)
				end
				l_attributes := a_attributes.attributes_with_all_data.twin
				if not l_attributes.is_empty then
					l_result.append_string (l_attributes)
				end
				l_attributes := l_result
			else
				if attached a_manual_attributes then
					create l_attributes.make_from_string (a_manual_attributes)
					if l_attributes.count > 2 then
						if not l_attributes [1].is_space then
							l_attributes.prepend_character (space)
						end
						l_attributes.right_adjust
					end
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

	frozen end_tag (a_tag: STRING): STRING
			-- End tag based on `a_tag'.
		do
			create Result.make (a_tag.count + 3)
			Result.append_character (left_angle)
			Result.append_character (end_slash)
			Result.append_string (a_tag)
			Result.append_character (right_angle)
		end

feature {NONE} -- Implementation: Attribute Primitives

	tag_attribute_quoted_value (a_key, a_value: STRING): STRING
			-- Create an HTML <tag [a_key]="[a_value]" ...> attribute.
		do
			Result := tag_attribute (a_key, "%"" + a_value + "%"")
		end

	tag_attribute (a_key, a_value: STRING): STRING
			-- Create an HTML <tag [a_key]=[a_value] ...> attribute.
		do
			Result := " "
			Result.append_string (a_key)
			Result.append_character ('=')
			Result.append_string (a_value)
			Result.append_character (' ')
		ensure
			has_key: Result.has_substring (a_key)
			has_value: Result.has_substring (a_value)
			has_equality: Result.has_substring ("=")
			padded: Result [1].is_space and Result [Result.count].is_space
		end

end
