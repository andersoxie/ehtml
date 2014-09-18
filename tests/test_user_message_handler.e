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

	HTML_CONSTANTS

	HTML_HELPER

feature -- Access

	response (a_request: WSF_REQUEST): WSF_RESPONSE_MESSAGE
			-- Traffic-cop for `a_request' from client.
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
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + ": " + m)
		end

	unsupported_method_response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + " only support: GET and POST; " + req.request_method + " is not supported.")
		end


	user_message_get (a_user: READABLE_STRING_32; req: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Response to client to get user message.
		local
			l_body: STRING_8
		do
			create Result.make
			l_body := "<p>No message from user '" + Result.html_encoded_string (a_user) + "'.</p>"
			l_body.append ("<form action=%""+ req.request_uri +"%" method=%"POST%">")
			l_body.append ("<textarea name=%"message%" rows=%"10%" cols=%"70%" ></textarea>")
			l_body.append ("<input type=%"submit%" value=%"Ok%" />")
			l_body.append ("</form>")
			Result.set_body (l_body)
		end

	user_message_response_post (a_user: READABLE_STRING_32; a_request: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Response to client based on `a_request' to show message fetched from `a_user'.
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

end
