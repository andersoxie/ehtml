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
	glossary: "[Glossary of Terms]"
	term: "[
		EWF: Eiffel Web Framework
		]"
	EIS: "name=EWF", "src=http://eiffelwebframework.github.io/EWF/getting-started/", "protocol=URI"
	design: "[
		1. Go ahead and create the objects representing HTML_TABLE. Consider all "large" or "reusable" items
			get built at objects and other (variable) bits are generated on-the-fly.
		2. Within the HTML_OBJECT, consider a STRING feature for each part (e.g. tags, attributes, content, etc)
			as these can be assembled around variable content as an append.
		3. Consider a caching system where objects are cleaned and saved instead of being GC'd.
		4. Carry the notion of HTML_TABLE to HTML_TABLE_FACTORY, which knows all of the various ways
			to create an HTML_TABLE (either as an object or just as a STRING).
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_FACTORY

inherit
	HTML_ELEMENT_HELPER

	HTML_GLOBAL_ATTRIBUTES
		undefine
			default_create
		end

feature -- Access

	html_page (a_content, a_language_code, a_doctype_attributes: detachable STRING): STRING
			-- <!doctype lang=[a_language_code]/> %N <html> %N [a_body] %N </html>
		require
			valid_lang_code: attached a_language_code implies language_codes.has (a_language_code)
		local
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

feature -- Access: Tables

	table_data (a_id: detachable STRING; a_content: STRING): STRING
			-- <td> [a_content] </td>
		note
			BNFE: "[
				Table_data ::=
					"<" Tag [ID_attribute "=" Double_quote `a_id' Double_quote] ">" 
					`a_content' 
					"</" Tag ">"
				]"
		require
			has_content: not a_content.is_empty
		do
			if attached a_id then
				Result := tag_contented (table_data_tag_name, tag_attribute_quoted_value ("id", a_id), a_content, no_global_attributes, has_end_tag, suppress_newlines)
			else
				Result := tag_contented (table_data_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
			end
		end

	content_tuple_anchor: detachable TUPLE [id: detachable STRING; content: STRING]
			-- Type anchor of some `content' with an optional `id'. DO NOT CALL! Type anchor only!
		note
			purpose: "[
				To provide a common type structure for HTML tag elements with some form of `content',
				and an optional `id'
				]"
			example: "[
				<Tag id="some_identifier_for_dom_access">[content]</Tag>
				]"
		require
			do_not_call: False
		attribute
			Result := Void
		end

	content_content_tuple_anchor: detachable TUPLE [id: detachable STRING; contents: attached like content_tuple_anchor]
			-- Type anchor of some repeating `contents' with an optional `id'. DO NOT CALL! Type anchor only!
		note
			purpose: "[
				To provide a common type structure for HTML tag elements with some form of `contents',
				and an optional `id', where `contents' are recursive `content_tuple_anchor' items.
				]"
			example: "[
				<Tag id="some_identifier_for_dom_access">
					[{<Tag2 id="some_identifier_for_dom_access">[content]</Tag2>}+]
				</Tag>
				]"
		require
			do_not_call: False
		attribute
			Result := Void
		end

	table_rows (a_contents: attached like content_content_tuple_anchor): STRING
		do
			create Result.make_empty
		end


	table_row (a_id: detachable STRING; a_contents: ARRAY [attached like content_tuple_anchor]): STRING
			-- <tr> {<td>[a_contents].item</td>}+ </tr>
		note
			description: "[
				An HTML <tr> with `a_contents' generated through `table_data'.
				]"
			BNFE: "[
				Table_row ::=
					Start_tag
					Table_data_items
					End_tag
				
				Start_tag ::=
					"<" Tag [ID_attribute "=" Double_quote `a_id' Double_quote] ">"	
				
				Table_data_items ::=
					{`table_data'}+
					
				End_tag ::=
					"</" Tag ">"
				]"
		require
			has_content: a_contents.count > 0
		local
			l_content: STRING
		do
			create l_content.make_empty
			across a_contents as ic_contents loop
				l_content.append_string (table_data (ic_contents.item.id, ic_contents.item.content))
			end
			if attached a_id then
				Result := tag_contented (table_row_tag_name, tag_attribute_quoted_value ("id", a_id), l_content, no_global_attributes, has_end_tag, suppress_newlines)
			else
				Result := tag_contented (table_row_tag_name, Void, l_content, no_global_attributes, has_end_tag, suppress_newlines)
			end
		end

	table_header (a_content: STRING): STRING
			-- <th> [a_content] </th>
		do
			Result := tag_contented (table_header_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
		end

	table_body (a_content: STRING): STRING
			-- <tbody> [a_content] </tbody>
		do
			Result := tag_contented (table_body_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
		end

	table (a_content: STRING): STRING
			-- <table> [a_content] </table>
		do
			Result := tag_contented (table_tag_name, Void, a_content, no_global_attributes, has_end_tag, suppress_newlines)
		end

feature -- Access: <p> ... </p>

	paragraph_with_header (a_heading_text, a_paragraph_text: STRING; a_heading_number: INTEGER): STRING
			-- create a <p> with `a_paragraph_text', with a preceding <hN> and `a_heading_text'.
		require
			valid_heading_number: a_heading_number > 0 and a_heading_number <= 4
		do
			create Result.make_empty
			inspect a_heading_number
			when 1 then
				Result.append_string (tag_contented (heading_1_tag_name, no_manaul_attributes, a_heading_text, no_global_attributes, has_end_tag, not suppress_newlines))
			when 2 then
				Result.append_string (tag_contented (heading_2_tag_name, no_manaul_attributes, a_heading_text, no_global_attributes, has_end_tag, not suppress_newlines))
			when 3 then
				Result.append_string (tag_contented (heading_3_tag_name, no_manaul_attributes, a_heading_text, no_global_attributes, has_end_tag, not suppress_newlines))
			when 4 then
				Result.append_string (tag_contented (heading_4_tag_name, no_manaul_attributes, a_heading_text, no_global_attributes, has_end_tag, not suppress_newlines))
			else
				check wrong_heading_value: False end
			end
			Result.append_string (paragraph (a_paragraph_text))
		end

	paragraph (a_content: STRING): STRING
			-- <p> [a_content] </p>
		do
			Result := tag_contented (paragraph_tag_name, Void, a_content, no_global_attributes, has_end_tag, not suppress_newlines)
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
			Result := a_item.twin
			across 1 |..| a_tab_count as ic_counter loop
				Result.prepend_character (tab)
			end
		ensure
			has_tab_count: Result.occurrences (tab) >= a_tab_count
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
