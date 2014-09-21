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
			elseif is_generate_color_initial then
				Result.append_string ("initial")
			else
				create Result.make_empty
			end
		end

	color_indentifier: STRING = "color"
			-- Color attribute keyword identifier.

	color_value: detachable STRING
			-- Color of Current.

	is_generate_color_initial: BOOLEAN
			-- Should Current generate "color:initial" when `color_value' is detached?

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
