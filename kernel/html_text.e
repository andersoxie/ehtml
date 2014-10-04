note
	description: "[
		Representation of a stream of HTML plain/raw text.
		]"
	cautions: "[
		1. Object instances of this class are not (presently) allowed to
			have `contents', but only `text' `content'. (see invariant).
			This is because any HTML-injection in plain/raw text ought
			to be handled by breaking the text stream up. For example:
			
			this is some <strong> text </strong> to display
			
			ought to be broken into three parts: (1) "this is some ",
			(2) <strong> with "text" as HTML_TEXT, and (3) " to display"
		]"
	EIS: "name=strong_text", "src=http://www.w3schools.com/tags/tag_strong.asp", "protocol=URI", "tag=w3schools"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_TEXT

inherit
	HTML_ELEMENT
		redefine
			html,
			content
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: like text)
			-- Initialize Current with `a_text' for `text'.
		do
			text := a_text.twin
		ensure
			text_set: text ~ a_text
		end

feature -- Access

	tag: STRING
			-- <tr> tag of Current.
		once
			create Result.make_empty
		end

	html (a_parent: STRING)
			-- <Precursor>
		note
			how: "[
				By removing any <start|end> tags and just appending
				the `content'.
				]"
		do
			content (a_parent)
		end

	content (a_parent: STRING)
			-- <Precursor>
		note
			how: "[
				By appending only the `text' feature contents.
				]"
		do
			a_parent.append_string (text)
		end

invariant
	no_contents: contents.count = 0

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
