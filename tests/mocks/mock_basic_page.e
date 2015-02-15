note
	description: "Summary description for {MOCK_BASIC_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOCK_BASIC_PAGE

inherit
	HTML_CONSTANTS
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			Precursor
			create factory
		end

feature -- Access

	html: STRING
			-- Main "Hello" web page HTML.
		local
			l_content: STRING
		do
			Result := factory.html_page (factory.head ("<meta charset=%"UTF-8%"%N<!-- myFirst html -->") + "%N" + body, "en-US", "")
		end

feature {NONE} -- Implementation

	body: STRING
		local
			l_content,
			l_header,
			l_paragraph: STRING
		do
			l_content := factory.paragraph_with_header ("This is my first web page!", "This is the first web page I've ever made, and I am extremely proud of it. it is so cool!", 1)
			Result := factory.tag_contented (body_tag_name, no_manaul_attributes, l_content, no_global_attributes, has_end_tag, not suppress_newlines)
		end

feature {NONE} -- Implementation: Factories

	factory: HTML_FACTORY
			-- Factory for current

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
