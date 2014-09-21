note	
	description: "[
				Test Handler to process /user/{user}/message/ requests
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_USER_MESSAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_RESPONSE_HANDLER
		rename
			response as user_request_response
		redefine
			default_create
		end

	HTML_CONSTANTS
		undefine
			default_create
		end

	HTML_HELPER
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create factory
		end

feature -- Access

	user_request_response (a_request: WSF_REQUEST): WSF_RESPONSE_MESSAGE
			-- Process /user/{user}/message/ `a_request' from client and respond with Result response message.
		note
			description: "[
				Calculated response to `a_request' based on "user-routed" message.
				]"
			purpose: "[
				To examine user-routed requests and respond with the appropriate HTML response.
				]"
			how: "[
				By examination of `a_request.path_parameter' (i.e. "route") and responding. Messages
				not being routed with "user" parameter are given an "error response", but all others
				are handled with a "Traffic-cop" (i.e. if-construct) conditional. Messages other than
				GET or POST are classified as unsupported and responded to appropriately.
				]"
		do
			if attached {WSF_STRING} a_request.path_parameter ("user") as al_user and then
					attached html_decoded_string (al_user.value) as al_user_name then
				if a_request.is_request_method (Get_method_name) then
					Result := user_message_get (al_user_name, a_request)
				elseif a_request.is_request_method (Post_method_name) then
					Result := user_message_response_post (al_user_name, a_request)
				else
					Result := unsupported_method_response (a_request)
				end
			else
				Result := missing_argument_response ("Missing parameter 'user'.", a_request)
			end
		end

	missing_argument_response (m: READABLE_STRING_8; req: WSF_REQUEST): WSF_PAGE_RESPONSE
			-- Respond to messages routed here but not "user" parameterized.
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + ": " + m)
		end

	unsupported_method_response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
			-- Respond to messages routed as "user", but not GET or POST.
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + " only support: GET and POST; " + req.request_method + " is not supported.")
		end


	user_message_get (a_user: READABLE_STRING_32; a_request: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Respond with a "Get-message" form.
		note
			EIS: "name=getting_user_message", "protocol=URI", "src=file:///./tests/getting_user_message.png"
		local
			l_body: STRING_8
			l_form,
			l_textarea,
			l_input,
			l_content: STRING
		do
			create Result.make
			l_body := factory.paragraph ("No message from user '" + Result.html_encoded_string (a_user) + "'.")
			l_textarea := factory.tag_contented ("textarea", "name=%"message%" rows=%"10%" cols=%"70%"", Void, no_global_attributes, has_end_tag, suppress_newlines)
			l_input := factory.submit_button ("Ok")
			l_content := l_textarea
			l_content.append_string (factory.indent_one_level_and_then_newline (l_input))
			l_content := factory.indent_one_level_and_then_newline (l_content)
			l_body.append_string (factory.form (l_content, "action=%""+ a_request.request_uri +"%" method=%"POST%""))
			Result.set_body (l_body)
		end

	user_message_response_post (a_user: READABLE_STRING_32; a_request: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Respond with the "user-message" response in a <textarea>.
		local
			l_body: STRING_8
		do
			create Result.make
			l_body := "<p>Message from user '<a href=%"/users/" + url_encoded_string (a_user) + "/%">" + Result.html_encoded_string (a_user) + "</a>'.</p>"
			if attached {WSF_STRING} a_request.form_parameter ("message") as al_message and then not al_message.is_empty then
				l_body.append ("<textarea>"+ al_message.value +"</textarea>")
			else
				l_body.append ("<strong>No or empty message!</strong>")
			end
			Result.set_body (l_body)
		end

feature {NONE} -- Implementation

	factory: HTML_FACTORY
			-- HTML Factory for Current.

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
