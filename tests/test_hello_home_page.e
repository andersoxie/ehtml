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
		do
			Result := hand_coded_html
			Result.replace_substring_all ("<<HEAD>>", head)
			Result.replace_substring_all ("<<BODY>>", body)
		end

feature -- Access: Hand-coded HTML

	hand_coded_html: STRING = "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
		<<HEAD>>
		<<BODY>>
	</html>
]"

feature {NONE} -- Implementation

	head: STRING
			-- Head Current: <head> ... title ... </head>
		do
			Result := factory.head (title)
		end

	title: STRING
			-- Title Current.
		do
			Result := factory.title ("EWF tutorial / Hello World!")
		ensure
			right_content: Result.same_string ("<title>EWF tutorial / Hello World!</title>")
		end

	body: STRING
			-- Body of Current
		local
			l_content: STRING
		do
			l_content := factory.indent_one_level_and_then_newline (Hello_message_content)
			l_content.append_string (factory.indent_one_level_and_then_newline (form_hello))
			Result := factory.tag_contented (body_tag_name, no_manaul_attributes, l_content, no_global_attributes, has_end_tag, not is_self_ending, not suppress_newlines)
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

end
