note
	title: "[
		Documentation Library eHTML
		]"
	description: "[
		Orientation/Learning Documentation for eHTML Library
		]"
	author: "Larry Rix"
	purpose: "[
		To facilitate your rapid learning of the eHTML library.
		]"
	design: "[
		Problem: 	Object creation on a web server is taboo because it is inefficient.
		Solution: 	Create-once-reuse-many as needed or possible (minimize creation/maximize reuse).
		
		Solution #1 (proposed): Code-snippet blocks of HTML/CSS, loaded once, with feature to access.
		Solution #2 (proposed): HTML generating factories, loaded once, with features to emit HTML. [3]
		Solution #3 (proposed): Pre-written support material (e.g. CSS, Javascript libraries).
		Solution #4 (proposed): Combination of #1, #2, and #3.
		
		NOTE: Two limits must be met (conservation is the rule-of-the-day):
			A) Minimal object creation and maximum HTML reuse or generation (emphasis gen-once-then-reuse).
			B) Minimal calculation (HTML generation).
			
		Way-forward:
			Step #1: Write out HTML/CSS/Javascript in full, giving Eiffel code option to place in response. [2]
			Step #2: See the patterns in the HTML/CSS/Javascript examples (3 or more) and teach 
				Eiffel to generate and replace in hand-code.[1]
				
		Footnotes:
		[1] See (for example) WOW-Slider (exampled in "Fusion" cluster), which has a program that is a
			code generator, but generates around Javascript, CSS, and HTML.
		[2] Start with the CSS-Slidy-gh-pages because the HTML is very simple and the JS is
			encapsulated in a *.js file.
		[3] Appending or prepending is reported as the fastest most efficient way to build strings.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOC_LIBRARY_EHTML

feature -- Documentation

	how_common_browser_works: detachable DOC_BROWSER
			-- Description of how the common browser works.
		note
			purpose: "[
				To arm you with information on how browsers (as clients) interact with web servers and then
				how browsers request information and how they process it once they have it. The goal is to
				know how to structure and format HTML/CSS/Javascript in such a way as to take advantage of
				the browser architecture.
				]"
			EIS: "name=how_browsers_work", "src=http://www.html5rocks.com/en/tutorials/internals/howbrowserswork/", "protocol=URI", "tag=external"
		attribute
			Result := Void
		end

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
