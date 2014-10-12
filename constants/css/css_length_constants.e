note
	description: "[
		CSS Length Constants
		]"
	EIS: "name=length_constants", "src=http://www.w3.org/TR/css3-values/#lengths", "protocol=URI", "tag=external"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	CSS_LENGTH_CONSTANTS

feature -- Status Report

	is_valid_uom (a_uom: STRING): BOOLEAN
			-- Is `a_uom' a valid length unit?
		do
			Result := absolute_units.has (a_uom) or
						relative_units.has (a_uom) or
						a_uom.same_string ("auto") or
						a_uom.same_string ("%%") or
						a_uom.same_string ("inherit")
		end

feature -- Constants: Relative Units

	auto: STRING = "auto"
			-- The browser calculates a margin

	inherit_kw: STRING = "inherit"
			-- Specifies that the margin should be inherited from the parent element

	percent: STRING = "%%"
			-- Specifies a margin in percent of the width of the containing element

	em: STRING = "em"
			--‘em’		font size of the element

	ex: STRING = "ex"
			--‘ex’		x-height of the element's font

	ch: STRING = "ch"
			--‘ch’		width of the "0" (ZERO, U+0030) glyph in the element's font

	rem: STRING = "rem"
			--‘rem’		font size of the root element

	vw: STRING = "vw"
			--‘vw’		1% of viewport's width

	vh: STRING = "vh"
			--‘vh’		1% viewport's height

	vmin: STRING = "vmin"
			--‘vmin’	1% of viewport's smaller dimension

	vmax: STRING = "vmax"
			--‘vmax’	1% of viewport's larger dimension

	relative_units: HASH_TABLE [STRING, STRING]
			-- Hash of `relative_units'.
		once
			create Result.make (8)
			Result.force ("element_size", em)
			Result.force ("element_font", ex)
			Result.force ("zero_glyph", ch)
			Result.force ("root_element", rem)
			Result.force ("viewport_width", vw)
			Result.force ("viewport_height", vh)
			Result.force ("viewport_smaller", vmin)
			Result.force ("viewport_larger", vmax)
		end

feature -- Constants: Absolute

	cm: STRING = "cm"
			--‘cm’	centimeters
	mm: STRING = "mm"
			--‘mm’	millimeters
	in: STRING = "in"
			--‘in’	inches; 1" is equal to 2.54 cm
	px: STRING = "px"
			--‘px’	pixels; 1px is equal to 1/96th"
	pt: STRING = "pt"
			--‘pt’	points; 1pt is equal to 1/72nd"
	pc: STRING = "pc"
			--‘pc’	picas; 1pc is equal to 12pt

	absolute_units: HASH_TABLE [STRING, STRING]
			-- Hash of `absolute_units'.
		once
			create Result.make (6)
			Result.force ("centimeters", cm)
			Result.force ("millimeters", mm)
			Result.force ("inches", in)
			Result.force ("pixels", px)
			Result.force ("points", pt)
			Result.force ("picas", pc)
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
