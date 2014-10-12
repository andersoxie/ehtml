note
	description: "[
		Representation of a "margin" CSS Style Rule Declaration.
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

		To shorten the code, it is possible to specify all the margin properties in one property. This is called a shorthand property.

		The shorthand property for all the margin properties is "margin":

		Example

		┌─────────────────────────────────────────┐
			p { margin: 100px 50px; }
		└─────────────────────────────────────────┘

		The margin property can have from one to four values.

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
	CSS_DECLARATION

	CSS_LENGTH_CONSTANTS

create
	make_shorthand_all,
	make_shorthand_t_lr_b,
	make_shorthand_tb_lr,
	make_shorthand_tlbr,
	make

feature {NONE} -- Initialization

	make_shorthand_all (a_top, a_bottom, a_left, a_right: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top', `a_bottom', `a_left', and `a_right' as `a_uom'.
		note
			purpose: "[
				Margin - Shorthand property

				margin: 25px 50px 75px 100px;
					top margin is 25px
					right margin is 50px
					bottom margin is 75px
					left margin is 100px
				]"
			EIS: "name=margin_shorthand", "src=http://www.w3schools.com/css/css_margin.asp", "protocol=URI", "tag=external"
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_top, a_uom], [a_bottom, a_uom], [a_left, a_uom], [a_right, a_uom]])
		end

	make_shorthand_t_lr_b (a_top, a_left_right, a_bottom: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top', `a_left_right', `a_bottom' as `a_uom'.
		note
			purpose: "[
				Margin - Shorthand property

				margin: 25px 50px 75px;
					[top] margin is 25px
					[right-and-left] margins are 50px
					bottom margin is 75px
				]"
			EIS: "name=margin_shorthand", "src=http://www.w3schools.com/css/css_margin.asp", "protocol=URI", "tag=external"
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_top, a_uom], [a_bottom, a_uom], [a_left_right, a_uom], [0, Void]])
		end

	make_shorthand_tb_lr (a_top_bottom, a_left_right: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top_bottom' and `a_left_right' as `a_uom'.
		note
			purpose: "[
				Margin - Shorthand property

				margin: 25px 50px;
					[top-and-bottom] margins are 25px
					[right-and-left] margins are 50px
				]"
			EIS: "name=margin_shorthand", "src=http://www.w3schools.com/css/css_margin.asp", "protocol=URI", "tag=external"
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_top_bottom, a_uom], [0, Void], [a_left_right, a_uom], [0, Void]])
		end

	make_shorthand_tlbr (a_tlbr: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_tlbr' as `a_uom'.
		note
			purpose: "[
				Margin - Shorthand property

				margin: 25px;
					[all-four] margins are 25px
				]"
			EIS: "name=margin_shorthand", "src=http://www.w3schools.com/css/css_margin.asp", "protocol=URI", "tag=external"
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_tlbr, a_uom], [0, Void], [0, Void], [0, Void]])
		end

	make (a_objects: attached like creation_objects_anchor)
			-- <Precursor>
		do
			top := a_objects.top
			bottom := a_objects.bottom
			left := a_objects.left
			right := a_objects.right
		end

feature -- Access

	string: STRING
			-- <Precursor>
		do
			Result := ""
			if attached top.uom and attached bottom.uom and attached left.uom and attached right.uom then
				Result := "margin "
				Result.append_string (top.value.out)
				Result.append_string (top.uom)
				Result.append_character (' ')
				Result.append_string (bottom.value.out)
				Result.append_string (bottom.uom)
				Result.append_character (' ')
				Result.append_string (left.value.out)
				Result.append_string (left.uom)
				Result.append_character (' ')
				Result.append_string (right.value.out)
				Result.append_string (right.uom)
				Result.append_character (';')
			elseif attached top.uom and attached bottom.uom and (not attached left.uom xor not attached right.uom) then
				Result := "margin "
				Result.append_string (top.value.out)
				Result.append_string (top.uom)
				Result.append_character (' ')
				if not attached left.uom then
					Result.append_string (right.value.out)
					Result.append_string (right.uom)
				else
					Result.append_string (left.value.out)
					Result.append_string (left.uom)
				end
				Result.append_character (' ')
				Result.append_string (bottom.value.out)
				Result.append_string (bottom.uom)
				Result.append_character (';')
			elseif attached top.uom and attached left.uom and (not attached bottom.uom and not attached right.uom) then
				Result := "margin "
				Result.append_string (top.value.out) -- Applies to top and bottom
				Result.append_string (top.uom)
				Result.append_character (' ')
				Result.append_string (left.value.out) -- Applies to right and left
				Result.append_string (left.uom)
				Result.append_character (';')
			elseif attached top.uom and (not attached bottom.uom and not attached left.uom and not attached right.uom) then
				Result := "margin "
				Result.append_string (top.value.out) -- Applies to top, bottom, right, and left
				Result.append_string (top.uom)
				Result.append_character (';')
			else -- Otherwise,
				if attached top.uom then
					Result := "margin-top:"
					Result.append_string (top.value.out)
					Result.append_string (top.uom)
					Result.append_character (';')
				end
				if attached bottom.uom then
					Result := "margin-bottom:"
					Result.append_string (bottom.value.out)
					Result.append_string (bottom.uom)
					Result.append_character (';')
				end
				if attached left.uom then
					Result := "margin-left:"
					Result.append_string (left.value.out)
					Result.append_string (left.uom)
					Result.append_character (';')
				end
				if attached right.uom then
					Result := "margin-right:"
					Result.append_string (right.value.out)
					Result.append_string (right.uom)
					Result.append_character (';')
				end
			end
		end

feature {NONE} -- Implementation

	top,
	bottom,
	left,
	right: TUPLE [value: INTEGER; uom: detachable STRING]

	creation_objects_anchor: detachable TUPLE [top, bottom, left, right: like top]
			-- Type anchor for objects required for creation.

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
