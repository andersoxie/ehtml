note
	description: "[
		Representation of an HTML Element Helper
		]"
	purpose: "[
		To provide delegate helper facilities to clients needing various HTML <element>
		functions, such as creating and formatting of start and end tags, as well as
		attributes of various forms.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_ELEMENT_HELPER

feature {NONE} -- Implementation: Tag Primitives

	frozen start_tag (a_tag: STRING; a_manual_attributes: detachable STRING; a_attributes: detachable HTML_GLOBAL_ATTRIBUTES; a_is_self_ending, a_suppress_newlines: BOOLEAN): STRING
			-- Start tag based on `a_tag'.
		local
			l_result,
			l_attributes: STRING
		do
			create l_attributes.make (100)
			if attached a_manual_attributes then
				l_attributes.append_string (a_manual_attributes)
			end
			if attached a_attributes then
				l_attributes.append_string (a_attributes.attributes_with_all_data)
			end
			if l_attributes.count > 2 then
				l_attributes.left_adjust
				l_attributes.right_adjust
				l_attributes.prepend_character ({HTML_GLOBAL_ATTRIBUTES}.space)
			end
			create Result.make (a_tag.count + 2 + l_attributes.count)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.left_angle)
			Result.append_string (a_tag)
			Result.append_string (l_attributes)
			if a_is_self_ending then
				Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.end_slash)
			end
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.right_angle)
			if not a_suppress_newlines then
				Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.newline)
			end
		end

	frozen end_tag (a_tag: STRING): STRING
			-- End tag based on `a_tag'.
		do
			create Result.make (a_tag.count + 3)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.left_angle)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.end_slash)
			Result.append_string (a_tag)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.right_angle)
		end

feature {NONE} -- Implementation: Attribute Primitives

	tag_attribute_quoted_value (a_key, a_value: STRING): STRING
			-- Create an HTML <tag [a_key]="[a_value]" ...> attribute.
		require
			has_key: not a_key.is_empty
			has_value: not a_value.is_empty
		local
			l_value: STRING
		do
			create l_value.make (2 + a_value.count)
			l_value.append_character ('"')
			l_value.append_string (a_value)
			l_value.append_character ('"')
			Result := tag_attribute (a_key, l_value)
		ensure
			has_quotes: Result.occurrences ('"') >= 2
		end

	tag_attribute (a_key, a_value: STRING): STRING
			-- Create an HTML <tag [a_key]=[a_value] ... > attribute.
		do
			create Result.make (3 + a_key.count + a_value.count)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.space)
			Result.append_string (a_key)
			Result.append_character ('=')
			Result.append_string (a_value)
			Result.append_character ({HTML_GLOBAL_ATTRIBUTES}.space)
		ensure
			has_key: Result.has_substring (a_key)
			has_value: Result.has_substring (a_value)
			has_equality: Result.has_substring ("=")
			padded: Result [1].is_space and Result [Result.count].is_space
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
