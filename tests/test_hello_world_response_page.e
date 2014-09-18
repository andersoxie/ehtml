note
	description: "Summary description for {TEST_HELLO_WORLD_RESPONSE_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HELLO_WORLD_RESPONSE_PAGE

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

	html_template: STRING do Result := original_html_response.twin end

	original_html_response: STRING = "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>EWF tutorial / Hello World!</title>

</head>
<body>
<p>Hello <<USER>>!</p>Display a <a href="/users/<<USER>>/message/">message</a></p><p>Click <a href="/users/<<USER>>/?op=quit">here</a> to quit.</p>
</body></html>
]"

end
