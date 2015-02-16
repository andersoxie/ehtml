note
	description: "[
		Dummies Chapter 4 - Nested List
		]"
	author: "Larry Rix"
	EIS: "name=basic_page", "protocol=URI", "tag=example",
			"src=http://www.aharrisbooks.net/haio"
	EIS: "name=basic_page", "protocol=URI", "tag=example",
			"src=http://www.aharrisbooks.net/haio/book_1/chap_4/nestedList.html"

class
	DUMMIES_CH_4_NESTED_LIST

inherit
	HTML_PAGE

	HTML_CONSTANTS
		undefine
			default_create
		end

create
	default_create,
	make_with_id

feature -- Access

	html: STRING
			-- Main "Hello" web page HTML.
		do
			Result := factory.html_page (factory.head ("<meta charset=%"UTF-8%"") + "%N" + body, "en-US", "")
		end

feature {NONE} -- Implementation

	body: STRING
		local
			l_content: STRING
		do
			l_content := factory.heading_1 ("Nested Lists")
			l_content.append_string (factory.heading_2 ("Popular Cat Names"))
			l_content.append_string (factory.unordered_list (<<
																	"USA%N%N" + factory.ordered_list (<<"Tigger", "Tiger", "Max", "Smokey", "Sam">>),
																	"Australia%N%N" + factory.ordered_list (<<"Oscar", "Max", "Tiger", "Sam", "Misty">>)
																>>))
			Result := factory.tag_contented (body_tag_name, no_manaul_attributes, l_content, no_global_attributes, has_end_tag, not suppress_newlines)
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
