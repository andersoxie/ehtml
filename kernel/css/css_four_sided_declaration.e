note
	title: "[
		Cascading Style Sheet 4-Sided Declaration
		]"
	description: "[
		Abstract notion of a CSS Declaration Rule managing 4-sides of "something".
		]"
	purpose: "[
		To provide generic features to manage CSS rule items which are 4-sided
		(e.g. top, bottom, left, and right sides).
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CSS_FOUR_SIDED_DECLARATION

inherit
	CSS_DECLARATION

	CSS_LENGTH_CONSTANTS

feature {NONE} -- Initialization

	make_shorthand_all (a_top, a_bottom, a_left, a_right: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top', `a_bottom', `a_left', and `a_right' as `a_uom'.
		do
			make ([[a_top, a_uom], [a_bottom, a_uom], [a_left, a_uom], [a_right, a_uom]])
			is_short_handed := True
		end

	make_shorthand_t_lr_b (a_top, a_left_right, a_bottom: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top', `a_left_right', `a_bottom' as `a_uom'.
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_top, a_uom], [a_bottom, a_uom], [a_left_right, a_uom], [0, Void]])
			is_short_handed := True
		end

	make_shorthand_tb_lr (a_top_bottom, a_left_right: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_top_bottom' and `a_left_right' as `a_uom'.
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_top_bottom, a_uom], [0, Void], [a_left_right, a_uom], [0, Void]])
			is_short_handed := True
		end

	make_shorthand_tblr (a_tlbr: INTEGER; a_uom: STRING)
			-- Initialize Current with `a_tlbr' as `a_uom'.
		require
			valid_uom: is_valid_uom (a_uom)
		do
			make ([[a_tlbr, a_uom], [0, Void], [0, Void], [0, Void]])
			is_short_handed := True
		end

	make (a_objects: attached like creation_objects_anchor)
			-- <Precursor>
		do
			top := a_objects.top
			bottom := a_objects.bottom
			left := a_objects.left
			right := a_objects.right
			is_short_handed := False
		end

feature -- Access

	string: STRING
			-- <Precursor>
		do
			Result := ""
			if not is_short_handed then
				create Result.make_empty
				if attached top.uom as al_uom then
					Result.append_string (name)
					Result.append_string ("-top:")
					Result.append_string (value_uom_pair (top.value, al_uom, inject_semicolon))
					Result.append_character (' ')
				end
				if attached bottom.uom as al_uom then
					Result.append_string (name)
					Result.append_string ("-bottom:")
					Result.append_string (value_uom_pair (bottom.value, al_uom, inject_semicolon))
					Result.append_character (' ')
				end
				if attached left.uom as al_uom then
					Result.append_string (name)
					Result.append_string ("-left:")
					Result.append_string (value_uom_pair (left.value, al_uom, inject_semicolon))
					Result.append_character (' ')
				end
				if attached right.uom as al_uom then
					Result.append_string (name)
					Result.append_string ("-right:")
					Result.append_string (value_uom_pair (right.value, al_uom, inject_semicolon))
					Result.append_character (' ')
				end
				Result.left_adjust
				Result.right_adjust
			elseif attached top.uom and attached bottom.uom and attached left.uom and attached right.uom then
				Result := name.twin
				Result.append_character (' ')
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
			elseif attached top.uom as al_top_uom and then
					attached bottom.uom as al_bottom_uom and then
					(not attached left.uom xor not attached right.uom) then
				Result := name.twin
				Result.append_character (' ')
				Result.append_string (value_uom_pair (top.value, al_top_uom, not inject_semicolon))
				if not attached left.uom and then attached right.uom as al_uom then
					Result.append_string (value_uom_pair (right.value, al_uom, not inject_semicolon))
				elseif attached left.uom as al_uom then
					Result.append_string (value_uom_pair (left.value, al_uom, not inject_semicolon))
				end
				Result.append_string (value_uom_pair (bottom.value, al_bottom_uom, inject_semicolon))
			elseif attached top.uom as al_top_uom and then attached left.uom as al_left_uom and (not attached bottom.uom and not attached right.uom) then
				Result := name.twin
				Result.append_character (' ')
				Result.append_string (value_uom_pair (top.value, al_top_uom, not inject_semicolon))
				Result.append_string (value_uom_pair (left.value, al_left_uom, inject_semicolon))
			elseif attached top.uom as al_top_uom and (not attached bottom.uom and not attached left.uom and not attached right.uom) then
				Result := name.twin
				Result.append_character (' ')
				Result.append_string (value_uom_pair (top.value, al_top_uom, inject_semicolon))
			end
		end

feature {NONE} -- Implementation

	value_uom_pair (a_value: INTEGER; a_uom: STRING; a_separate: BOOLEAN): STRING
			-- An well-formed value-uom pair.
		do
			if a_uom.same_string ({CSS_LENGTH_CONSTANTS}.auto) then
				check no_auto_value: a_value = 0 end
				Result := {CSS_LENGTH_CONSTANTS}.auto
			elseif a_uom.same_string ({CSS_LENGTH_CONSTANTS}.inherit_kw) then
				Result := {CSS_LENGTH_CONSTANTS}.inherit_kw
			else
				Result := a_value.out
				Result.append_string (a_uom)
				if a_separate then
					Result.append_character (';')
				else
					Result.append_character (' ')
				end
			end
		end

	top,
	bottom,
	left,
	right: TUPLE [value: INTEGER; uom: detachable STRING]
			-- Margin setting for `top', `bottom', `left', and `right' margins.

	inject_semicolon: BOOLEAN = True
			-- Semicolon character injection flag, default to True.

	is_short_handed: BOOLEAN
			-- Does Current `string' produce short-hand version or long-hand version?

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
