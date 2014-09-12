note
	description: "[
		Abstract helper with HTML Global Attributes to apply.
		]"
	how: "[
		By providing access to setting values and forming (deriving) HTML5 attributes from
		the set values. Also, by providing appropriate class invariants to ensure proper
		formatting of various HTML5 attributes at run-time.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTML_GLOBAL_ATTRIBUTES

feature -- Access

	access_key: STRING
			-- Well formed HTML "accesskey" global attribute.
		note
			purpose: "[
				The accesskey attribute specifies a shortcut key to activate/focus an element.
				]"
			how: "[
				By returning either an empty string, indicative of detached `access_key_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_accesskey.asp", "protocol=URI"
		do
			check attached access_key_attribute_value as al_value then
				Result := well_formed_html_attribute (access_key_identifier, al_value, is_double_quoted)
			end
		end

	access_key_attribute_value: detachable STRING
			-- HTML "access_key" global attribute value (optional). See `access_key_attribute' above and setter/reset below.

	access_key_identifier: STRING = "accesskey"
			-- Identifier constants for `access_key'.

	class_attribute: STRING
			-- Well formed HTML "class" global attribute.
		note
			purpose: "[
				The class attribute specifies one or more classnames for an element.
				
				The class attribute is mostly used to point to a class in a style sheet. However, it can also 
				be used by a JavaScript (via the HTML DOM) to make changes to HTML elements with a specified 
				class.
				]"
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				
				In HTML5, the class attribute can be used on any HTML element (it will validate on any HTML element. 
				However, it is not necessarily useful).
				
				In HTML 4.01, the class attribute cannot be used with: <base>, <head>, <html>, <meta>, <param>, 
					<script>, <style>, and <title>.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_class.asp", "protocol=URI"
			examples: "[
				Syntax: <element class="classname">
				]"
		do
			check attached class_attribute_value as al_value then
				Result := well_formed_html_attribute (class_identifier, al_value, is_double_quoted)
			end
		end

	class_attribute_value: detachable STRING
			-- HTML "class" global attribute value (optional). See `class_attribute' above and setter/reset below.

	class_identifier: STRING = "class"
			-- Identifier constants for `class_attribute'.

	content_editable_attribute: STRING
			-- Well formed HTML "class" global attribute.
		note
			purpose: "[
				The contenteditable attribute specifies whether the content of an element is editable or not.
				
				Note: When the contenteditable attribute is not set on an element, the element will inherit it from its parent.
				]"
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_contenteditable.asp", "protocol=URI"
			examples: "[
				Syntax: <element contenteditable="true|false">
				
				Attribute Values
				====================
				Value	Description
				------- ------------------------------------------
				true	Specifies that the element is editable
				false	Specifies that the element is not editable
				]"
		local
			l_flag: STRING
		do
			l_flag := content_editable_attribute_value.out
			l_flag.to_lower
			Result := well_formed_html_attribute (content_editable_identifier, l_flag, is_double_quoted)
		end

	content_editable_attribute_value: BOOLEAN
			-- HTML "contenteditable" global attribute value ("false" by default). See `content_editable_attribute' above and setter/reset below.

	content_editable_identifier: STRING = "contenteditable"
			-- Identifier constants for `content_editable_attribute'.

	data_attribute (a_key: STRING): STRING
			-- Well formed HTML "data=*" global attribute.
		note
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value' or a 
				fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_data.asp", "protocol=URI"
			examples: "[
				Syntax: <element data-*="somevalue">
				
				Retrieve from this list by: Current.data_attributes ["animal-type-bird"] from: item alias "[]" (key: K): detachable G
				]"
		require
			has_key_value: data_attributes.has (a_key)
		do
			check has_value: attached {like data_attribute_value_anchor} data_attributes [a_key] as al_value then
				Result := well_formed_html_attribute (data_identifier + al_value.attribute_name, al_value.attribute_value, is_double_quoted)
			end
		end

	data_attributes: HASH_TABLE [TUPLE [STRING, STRING], STRING]
			-- Hash of data attributes, name and value (key-value pairs).
		note
			purpose: "[
				The data-* attributes is used to store custom data private to the page or application.
				The data-* attributes gives us the ability to embed custom data attributes on all HTML elements.
				
				The stored (custom) data can then be used in the page's JavaScript to create a more engaging user 
				experience (without any Ajax calls or server-side database queries).
				
				The data-* attributes consist of two parts:
				
				1. The attribute name should not contain any uppercase letters, and must be at least one character long
				after the prefix "data-"
				2. The attribute value can be any string
				
				Note: Custom attributes prefixed with "data-" will be completely ignored by the user agent [g].
				]"
			examples: "[
				Retrieve from this list by: Current.data_attributes ["animal-type-bird"] from: item alias "[]" (key: K): detachable G
			glossary: "[
				user agent: In computing, a user agent is software (a software agent) that is acting on behalf 
								of a user. For example, an email reader is a mail user agent, and in the Session 
								Initiation Protocol (SIP), the term user agent refers to both end points of a 
								communications session.
				]"
		attribute
			create Result.make (0)
		end

	data_identifier: STRING = "data-"
			-- Identifier constants for `data_attribute'.

feature -- Status Report: Contract Support

	frozen is_valid_attribute_value (a_value: STRING): BOOLEAN
			-- Is `a_value' a valid attribute value?
		note
			how: "[
				`a_value' must start with A-Z|a-z and the remaining characters must conform to
					A-Z|a-z|0-9|"_"|"-" and cannot be empty.
				]"
		do
			Result := a_value.count > 0
			Result := Result and ({HTML_CONSTANTS}.uppercase_a_to_z.has (a_value [1]) or
									{HTML_CONSTANTS}.lowercase_a_to_z.has (a_value [1]))
			Result := Result and across a_value as ic_content all
										{HTML_CONSTANTS}.uppercase_a_to_z.has (ic_content.item) or
										{HTML_CONSTANTS}.lowercase_a_to_z.has (ic_content.item) or
										{HTML_CONSTANTS}.numeric_digits.has (ic_content.item) or
										{HTML_CONSTANTS}.special_characters.has (ic_content.item)
									end
		end

feature -- Settings

	set_access_key_attribute_value (a_access_key_attribute_value: attached like access_key_attribute_value)
			-- Sets `access_key_attribute_value' with `a_access_key_attribute_value'.
		do
			access_key_attribute_value := a_access_key_attribute_value
		ensure
			access_key_attribute_value_set: access_key_attribute_value = a_access_key_attribute_value
		end

	reset_access_key_attribute_value
			-- Resets `access_key_attribute_value' to Void.
		do
			access_key_attribute_value := Void
		end

	set_class_attribute_value (a_class_attribute_value: attached like class_attribute_value)
			-- Sets `class_attribute_value' with `a_class_attribute_value'.
		do
			class_attribute_value := a_class_attribute_value
		ensure
			class_attribute_value_set: class_attribute_value = a_class_attribute_value
		end

	reset_class_attribute_value
			-- Resets `class_attribute_value' to Void.
		do
			class_attribute_value := Void
		end

	set_content_editable_attribute_value (a_content_editable_attribute_value: attached like content_editable_attribute_value)
			-- Sets `content_editable_attribute_value' with `a_content_editable_attribute_value'.
		do
			content_editable_attribute_value := a_content_editable_attribute_value
		ensure
			content_editable_attribute_value_set: content_editable_attribute_value = a_content_editable_attribute_value
		end

	reset_content_editable_value
			-- Resets `content_editable_attribute_value' to Void.
		do
			content_editable_attribute_value := False
		end

	set_data_attribute (a_value: attached like data_attribute_value_anchor; a_key: STRING)
			-- Set `a_value' and `a_key' into `data_attributes'.
		do
			data_attributes.force (a_value, a_key)
		ensure
			has_entry: attached {attached like data_attribute_value_anchor} data_attributes.at (a_key) as al_value and then
						al_value.attribute_name.same_string (a_value.attribute_name) and then
						al_value.attribute_value.same_string (a_value.attribute_value)
		end

	data_attribute_value_anchor: detachable TUPLE [attribute_name, attribute_value: STRING]

feature {NONE} -- Implementation: Basic Operations

	well_formed_html_attribute (a_name, a_value: STRING; a_is_quoted: BOOLEAN): STRING
			-- Create well-formed attribute with `a_name', equal ("=") to `a_value', with possible double quotes.
		require
			has_name: not a_name.is_empty
			has_value: not a_value.is_empty
		do
			Result := a_name.twin
			Result.append_character ('=')
			if a_is_quoted then
				Result.append_character ('"')
			end
			Result.append_string (a_value)
			if a_is_quoted then
				Result.append_character ('"')
			end
		ensure
			has_name_equal: Result.has_substring (a_name + "=")
			has_value: Result.has_substring (a_value)
			is_valid_quotations: a_is_quoted implies Result.has_substring ("%"" + a_value + "%"")
			has_equality_symbol: Result.has ('=')
		end

feature {NONE} -- Implementation: Constants

	frozen is_double_quoted: BOOLEAN
			-- Named BOOLEAN constant indicative of some item wrapped in double-quotes.
		once
			Result := {HTML_CONSTANTS}.is_double_quoted
		end

invariant
	valid_class_attribute_value: attached class_attribute_value as al_value implies is_valid_attribute_value (al_value)
	valid_access_key_attribute_value: attached access_key_attribute_value as al_value implies is_valid_attribute_value (al_value)
	valid_data_values: data_attributes.count > 0 implies
						across data_attributes as ic_data all
							attached {like data_attribute_value_anchor} ic_data.item as al_data and then
								is_valid_attribute_value (al_data.attribute_value)
						end

end
