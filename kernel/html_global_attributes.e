note
	description: "[
		Abstract helper with HTML Global Attributes to apply.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTML_GLOBAL_ATTRIBUTES

feature -- Access

	class_attribute: STRING
			-- HTML "class" global attribute.
		do
			create Result.make_empty
			if has_class_attribute_value then
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

	is_valid_attribute_value (a_value: STRING): BOOLEAN
			-- Is `a_value' a valid attribute value?
		do
			Result := {HTML_CONSTANTS}.uppercase_a_to_z.has (a_value [1])
			Result := Result or {HTML_CONSTANTS}.lowercase_a_to_z.has (a_value [1])
			Result := Result and across a_value as ic_content all
										{HTML_CONSTANTS}.uppercase_a_to_z.has (ic_content.item) or
										{HTML_CONSTANTS}.lowercase_a_to_z.has (ic_content.item) or
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
