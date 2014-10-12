note
	description: "[
		Representation of a "margin" CSS Style Rule Declaration.
		]"
	how: "[
		By providing either a short-hand version or long-hand version of the "margin" CSS Declaration.
		
		1. Calls directly to the `make' will always produce a long-handed version.
		2. Calls directly to `make_shorthand_*' always produce a short-handed version.
		3. Margins set to "auto" and "inherit" will ignore the `a_value: INTEGER' because no value is needed.
			Passing a non-zero value will result in an invariant failure.
		]"
	design: "[
		Value		Description
		==========	============================
		auto		The browser calculates a margin
		length		Specifies a margin in px, pt, cm, etc. Default value is 0px
		%			Specifies a margin in percent of the width of the containing element
		inherit		Specifies that the margin should be inherited from the parent element
		
		NOTE: It is also possible to use negative values, to overlap content.
		
		┌─────────────────────────────────────────┐
			p { margin-top: 100px;
			    margin-bottom: 100px;
			    margin-right: 150px;
			    margin-left: 50px; }
		└─────────────────────────────────────────┘

		Margin - Shorthand property

		To shorten the code, it is possible to specify all the margin properties in one property.
			This is called a shorthand property. The shorthand property for all the margin properties
			is "margin":

		┌─────────────────────────────────────────┐
			p { margin: 100px 50px; }
		└─────────────────────────────────────────┘

		The "margin" (short-hand) property can have from one to four values.

		margin: 25px 50px 75px 100px;
			top margin is 25px
			right margin is 50px
			bottom margin is 75px
			left margin is 100px

		margin: 25px 50px 75px;
			top margin is 25px
			right and left margins are 50px
			bottom margin is 75px

		margin: 25px 50px;
			top and bottom margins are 25px
			right and left margins are 50px

		margin: 25px;
			all four margins are 25px

		]"
	EIS: "name=margins", "src=http://www.w3schools.com/css/css_margin.asp", "protocol=URI", "tag=external"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	CSS_MARGIN

inherit
	CSS_FOUR_SIDED_DECLARATION

create
	make_shorthand_all,
	make_shorthand_t_lr_b,
	make_shorthand_tb_lr,
	make_shorthand_tblr,
	make

feature {NONE} -- Implementation

	name: STRING = "margin"
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

;note
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
