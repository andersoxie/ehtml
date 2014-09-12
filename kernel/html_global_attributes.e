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
			-- HTML "class" global attribute.
		note
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_class.asp", "protocol=URI"
		do
			create Result.make_empty
			if has_class_attribute_value then
				Result.append_string ("class=%"")
				check attached class_attribute_value end
				Result.append_string (class_attribute_value)
				Result.append_character ('"')
			else
			end
		end

	class_attribute_value: detachable STRING
			-- HTML "class" global attribute value (optional).

feature -- Status Report

	has_class_attribute_value: BOOLEAN
			-- Does Current have optional `class_attribute_value'?
		do
			Result := attached class_attribute_value
		end

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

invariant
	valid_class_attribute_value: attached class_attribute_value as al_value implies is_valid_attribute_value (al_value)

end
