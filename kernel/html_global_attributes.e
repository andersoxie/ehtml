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

	class_attribute: STRING
			-- Well formed HTML "class" global attribute.
		note
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_class.asp", "protocol=URI"
		do
			check attached class_attribute_value as al_value then
				Result := well_formed_html_attribute ("class", al_value, is_double_quoted)
			end
		end

	class_attribute_value: detachable STRING
			-- HTML "class" global attribute value (optional). See `class_attribute' above and setter/reset below.

feature -- Status Report

	has_class_attribute_value: BOOLEAN
			-- Does Current have optional `class_attribute_value'?
		do
			Result := attached class_attribute_value
		ensure
			valid_result: Result implies attached class_attribute_value
		end

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

feature {NONE} -- Implementation: Basic Operations

	well_formed_html_attribute (a_name, a_value: STRING; a_is_quoted: BOOLEAN): STRING
			-- Create well-formed attribute with `a_name', equal ("=") to `a_value', with possible double quotes.
		require
			has_name: not a_name.is_empty
			has_value: not a_value.is_empty
		do
			Result := a_name
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

end
