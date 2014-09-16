note
	title: "[
		Documentation Library eHTML
		]"
	description: "[
		Orientation/Learning Documentation for eHTML Library
		]"
	author: "Larry Rix"
	purpose: "[
		To document and orient you to rapid learning of the eHTML library.
		]"
	design: "[
		Problem: Object creation on a web server is taboo because it is inefficient. Create
			objects once and use-reset/reuse as needed.
		Solution #1 (proposed): Code-snippet blocks of HTML, loaded once, with feature to access.
		Solution #2 (proposed): HTML generating factories, loaded once, with features to emit HTML. [3]
		Solution #3 (proposed): Pre-written support material (e.g. CSS, Javascript libraries).
		Solution #4 (proposed): Combination of #1, #2, and #3.
		
		NOTE: Two limits must be met:
			A) Minimal object creation and maximum HTML generation.
			B) Minimal calculation (HTML generation).
			
		Way-forward:
			Step #1: Write out HTML/Javascript in full, giving Eiffel code option to place 
				in response. [2]
			Step #2: See the patterns in the HTML/Javascript examples (3 or more) and teach 
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

end
