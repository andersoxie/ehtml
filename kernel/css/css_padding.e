note
	title: "[
		Cascading Style Sheet Padding Declaration
		]"
	description: "[
		Representation of a "padding" CSS Style Rule Declaration.
		]"
	how: "[
		By providing properties to define the space between the element border 
		and the element content.
		]"
	EIS: "name=margins", "src=http://www.w3schools.com/css/css_padding.asp", "protocol=URI", "tag=external"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	CSS_PADDING

inherit
	CSS_FOUR_SIDED_DECLARATION

create
	make_shorthand_all,
	make_shorthand_t_lr_b,
	make_shorthand_tb_lr,
	make_shorthand_tblr,
	make

feature {NONE} -- Implementation

	name: STRING = "padding"
			-- <Precursor>

invariant
	valid_top: attached top.uom as al_uom implies
					((al_uom.same_string ({CSS_LENGTH_CONSTANTS}.auto) xor
						al_uom.same_string ({CSS_LENGTH_CONSTANTS}.inherit_kw)) implies top.value = 0) and then is_valid_uom (al_uom)
	valid_bottom: attached bottom.uom as al_uom implies
					((al_uom.same_string ({CSS_LENGTH_CONSTANTS}.auto) xor
						al_uom.same_string ({CSS_LENGTH_CONSTANTS}.inherit_kw)) implies bottom.value = 0) and then is_valid_uom (al_uom)
	valid_left: attached left.uom as al_uom implies
					((al_uom.same_string ({CSS_LENGTH_CONSTANTS}.auto) xor
						al_uom.same_string ({CSS_LENGTH_CONSTANTS}.inherit_kw)) implies left.value = 0) and then is_valid_uom (al_uom)
	valid_right: attached right.uom as al_uom implies
					((al_uom.same_string ({CSS_LENGTH_CONSTANTS}.auto) xor
						al_uom.same_string ({CSS_LENGTH_CONSTANTS}.inherit_kw)) implies right.value = 0) and then is_valid_uom (al_uom)

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
