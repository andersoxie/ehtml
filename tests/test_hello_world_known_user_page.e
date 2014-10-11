note
	title: "[
		Test Hello World Known-user Response Page
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HELLO_WORLD_KNOWN_USER_PAGE

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

	html (a_user: WSF_STRING): STRING
			-- Main "Hello" web page HTML.
		do
			Result := html_template
			Result.replace_substring_all ("<<USER>>", a_user.url_encoded_value)
		end

feature {NONE} -- Implementation: Factories

	factory: HTML_FACTORY
			-- Factory for current

feature {NONE} -- Implementation: Constants

	html_template: STRING
			-- Copy of HTML template with <<USER>> replacement tag.
		do
			Result := original_html_response.twin
		end

	original_html_response: STRING = "[
<p>Hello <<USER>>!</p>Display a <a href="/users/<<USER>>/message/">message</a></p><p>Click <a href="/users/<<USER>>/?op=quit">here</a> to quit.</p>
]"

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
