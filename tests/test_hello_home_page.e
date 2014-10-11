note
	description: "[
		Representation of a Test Hello Home Page
		]"
	purpose: "[
		To model the same hello home page from the EWF tutorial hello project.
		]"
	how: "[
		By ???
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HELLO_HOME_PAGE

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
			Result := factory.indent_one_level_and_then_newline (body.twin)
		end

feature {NONE} -- Implementation

	body: STRING
			-- Body of Current
		local
			l_content: STRING
		do
			l_content := factory.indent_one_level_and_then_newline (Hello_message_content)
			l_content.append_string (factory.indent_one_level_and_then_newline (form_hello))
			Result := factory.tag_contented (body_tag_name, no_manaul_attributes, l_content, no_global_attributes, has_end_tag, not suppress_newlines)
		ensure
			has_hello_content: Result.has_substring (hello_message_content)
		end

	hello_message_content: STRING = "Hello / ahoj / &#2344;&#2350;&#2360;&#2381;&#2340;&#2375; / Ci&#224;o / &#1605;&#1585;&#1581;&#1576;&#1575; / Hola / &#20320;&#22909; / Hallo / Selam / Bonjour"

	form_hello: STRING
			-- Form: <form action="/hello" method="GET"> ... l_form_body ... </form>
		local
			l_form_body: STRING
		do
			l_form_body := factory.indent_one_level_and_then_newline (full_name_paragraph)
			l_form_body.append_string (factory.indent_one_level_and_then_newline (user_name_input_text_field))
			l_form_body.append_string (factory.indent_one_level_and_then_newline (input_submit_button))
			Result := factory.form (l_form_body, "action=%"/hello%" method=%"GET%"")
		end

	full_name_paragraph: STRING
			-- Paragraph for name statement
		do
			Result := factory.tag_contented_no_global_attributes (paragraph_tag_name, Void, "What is your full name?")
		end

	user_name_input_text_field: STRING
			-- Name input form tag: <input type="text" name="user"/>
		do
			Result := factory.input_text_field ("user")
		end

	input_submit_button: STRING
			-- Submit input form tag: <input type="submit" value="Validate"/>
		do
			Result := factory.submit_button ("Validate")
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
