note
	description: "[
		Global CSS Style attributes for HTML5.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_GLOBAL_STYLE

feature -- Access

	color_attribute: STRING
			-- HTML5 CSS color attribute
		do
			Result := color_indentifier.twin
			Result.append_character (':')
			if is_inherit_color then
				Result.append_string ("inherit")
			elseif attached color_value then
				Result.append_string (color_value)
			else
				Result.append_string ("initial")
			end
		end

	color_indentifier: STRING = "color"
			-- Color attribute keyword identifier.

	color_value: detachable STRING
			-- Color of Current.

	is_inherit_color: BOOLEAN
			-- Does Current inherit its color from the parent element?

feature -- Settings

	set_color_value (a_color_value: attached like color_value)
			-- Sets `color_value' with `a_color_value'.
		do
			color_value := a_color_value
		ensure
			color_value_set: color_value = a_color_value
		end

	set_is_inherit_color (a_is_inherit_color: like is_inherit_color)
			-- Sets `is_inherit_color' with `a_is_inherit_color'.
		do
			is_inherit_color := a_is_inherit_color
		ensure
			is_inherit_color_set: is_inherit_color = a_is_inherit_color
		end

end
