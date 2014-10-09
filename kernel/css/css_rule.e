note
	description: "[
		Abstract notion of a CSS Rule.
		]"
	design_notes: "[
		IMPORTANT: This is a generator, where the goal is simple: API (Eiffel-classes) --> CSS-3 <style>
		
		1. Storage of CSS files is not needed. This is a server-side convenience and not a browser consumer
			necessity. What is important is to have the appropriate CSS embedded in HTML page <style> on-demand.
			Whether this <style> element is wholly constructed, living in memory, and ready-to-go -OR- if
			it is partially stored in-memory and partially calculated on-demand is a matter of design, debate,
			and (most importantly) Use-case-driven.
		2. The goal and purpose of the API is the convenience and speed-of-development (learnability and reuse)
			of the programmer. The subsequent consequence of this goal is well-formed and properly structured
			CSS-3 <style> elements, ready for serving up to client browsers.
		3. An additional goal is to be able to quickly combine CSS needs of various HTML-5 elements. This
			combinatory property of the code generating the CSS-3 is a powerful goal that must be the aim
			of this design/build/test effort!
		4. Find the CSS-3 BNF-E grammar and parsing information on-line. Buy a book if that is what is needed.
		]"
	EIS: "name=w3schools_css_selectors", "src=http://www.w3.org/TR/css3-selectors/", "protocol=URI", "tag=w3schools"
	EIS: "name=w3schools_specifications", "src=http://www.w3.org/TR/css3-syntax/#parser-diagrams", "protocol=URI", "tag=w2schools"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CSS_RULE

feature -- Access

	selectors: ARRAYED_LIST [CSS_SELECTOR]
			-- List of "selector" items for Current.
		attribute
			create Result.make (0)
		end

	property_values: ARRAYED_LIST [TUPLE [property, value: STRING]]
			-- List of `property' and `value' pairs.
		attribute
			create Result.make (0)
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
