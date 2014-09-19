note
	description : "[
		Test Application Root
		]"
	purpose: "[
		To demonstrate in a test environment, the eHTML library producing (generating)
		the appropriate code to replicate the EWF tutorial "hello" application.
		]"
	how: "[
		This test demonstration is based on the EWF Tutorial "hello" application. The
		project target is presently located at: "{..}\ewf\examples\tutorial\step_4\hello"
		
		This APPLICATION class is roughly modeled after the EWF example, but replaces
		hand-coded HTML with generated HTML from this library (eHTML). The primary classes
		to pay attention to are listed in the "?" section below.
		]"
	
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	WSF_ROUTED_SERVICE

	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end

	HTML_CONSTANTS

create
	make_and_launch

feature {NONE} -- Initialization

	setup_router
			-- See `setup_router' class-feature notes (below).
		do
			map_agent_uri ("/hello", agent execute_hello, Void)
			map_uri_template ("/users/{user}/message/{mesgid}", create {TEST_USER_MESSAGE_HANDLER}, router.methods_HEAD_GET_POST)
			map_uri_template ("/users/{user}/message/", create {TEST_USER_MESSAGE_HANDLER}, router.methods_GET_POST)
			map_agent_uri_template_response ("/users/{user}/{?op}", agent response_user, router.methods_GET)
		end

	initialize
			-- See `initialize' class-feature notes (below).
		do
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file (configuration_file)
			Precursor
			initialize_router
		end

feature -- Execution

	execute_hello (a_request: WSF_REQUEST; a_response: WSF_RESPONSE)
			-- See `execute_hello' class-feature notes (below).
		local
			l_message: WSF_HTML_PAGE_RESPONSE
			l_html_response: STRING_8
			l_user_name: READABLE_STRING_32
		do
			create l_message.make
			l_message.set_title ("EWF tutorial / Hello World!")
			if attached {WSF_STRING} a_request.item (user_parameter_keyword) as al_user then
				l_html_response := (create {TEST_HELLO_WORLD_RESPONSE_PAGE}).html (al_user)
			else
				--| Otherwise, ask for name
				l_html_response := (create {TEST_HELLO_HOME_PAGE}).html
			end
			l_message.set_body (l_html_response)
			a_response.send (l_message)
		end

feature -- Response: User

	response_user (a_request: WSF_REQUEST): WSF_RESPONSE_MESSAGE
			-- Computed response message.
		local
			l_response_html: WSF_HTML_PAGE_RESPONSE
			l_redirection_response: WSF_HTML_DELAYED_REDIRECTION_RESPONSE
			l_body_html: STRING_8
			l_username: STRING_32
		do
			if attached {WSF_STRING} a_request.path_parameter (user_parameter_keyword) as al_user then
				l_username := (create {HTML_ENCODER}).general_decoded_string (al_user.value)
				if
					attached {WSF_STRING} a_request.query_parameter (op_parameter_keyword) as al_op_parm
				then
					if al_op_parm.is_case_insensitive_equal (quit_operation_keyword) then
						create l_redirection_response.make (a_request.script_url ("/hello"), 3)
						create l_response_html.make
						l_redirection_response.set_title ("Bye " + l_response_html.html_encoded_string (l_username))
						l_redirection_response.set_body ("Bye " + l_response_html.html_encoded_string (l_username) + ",<br/> see you soon.<p>You will be redirected to " +
										l_redirection_response.url_location + " in " + l_redirection_response.delay.out + " second(s) ...</p>"
								)
						Result := l_redirection_response
					else
						create l_response_html.make
						l_response_html.set_title ("Bad request")
						l_response_html.set_body ("Bad request: unknown operation '" + al_op_parm.url_encoded_value + "'.")
						Result := l_response_html
					end
				else
					create l_response_html.make

					l_body_html := "<p>User <em>'" + l_response_html.html_encoded_string (l_username)  + "'</em>!</p>"
					l_body_html.append ("Display a <a href=%"/users/" + al_user.url_encoded_value + "/message/%">message</a></p>")
					l_body_html.append ("<p>Click <a href=%"/users/" + al_user.url_encoded_value + "/?op=" + quit_operation_keyword + "%">here</a> to quit.</p>")
					l_response_html.set_title ("User '" + al_user.url_encoded_value + "'")
					l_response_html.set_body (l_body_html)
					Result := l_response_html
				end
			else
				create l_response_html.make
				l_response_html.set_title ("Bad request")
				l_response_html.set_body ("Bad request: missing user parameter")
				Result := l_response_html
			end
		end

feature -- Helper: mapping

	map_agent_uri (a_uri: READABLE_STRING_8; a_action: like {WSF_URI_AGENT_HANDLER}.action; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- See `map_agent_uri' class-feature notes (below).
		do
			router.map_with_request_methods (create {WSF_URI_MAPPING}.make (a_uri, create {WSF_URI_AGENT_HANDLER}.make (a_action)), rqst_methods)
		end

	map_agent_uri_template_response (a_uri_template: READABLE_STRING_8; a_action: like {WSF_URI_TEMPLATE_RESPONSE_AGENT_HANDLER}.action; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- See `map_agent_uri_template_response' class-feature notes (below).
		do
			router.map_with_request_methods (create {WSF_URI_TEMPLATE_MAPPING}.make (a_uri_template, create {WSF_URI_TEMPLATE_RESPONSE_AGENT_HANDLER}.make (a_action)), rqst_methods)
		end

	map_uri_template (a_uri_template: READABLE_STRING_8; a_handler: WSF_URI_TEMPLATE_HANDLER; a_request_methods: detachable WSF_REQUEST_METHODS)
			-- ???
		do
			router.map_with_request_methods (create {WSF_URI_TEMPLATE_MAPPING}.make (a_uri_template, a_handler), a_request_methods)
		end

feature {NONE} -- Implementation: Constants

	configuration_file: STRING = "ewf.ini"
			-- Configuration file used to initialize Current.

	user_parameter_keyword: STRING = "user"
			-- Keyword for "user" parameter.

note
	copyright: "Copyright (c) 2010-2014, Jinny Corp."
	copying: "[
			Duplication and distribution prohibited. May be used only with
			Jinny Corp. software products, under terms of user license.
			Contact Jinny Corp. for any other use.
			]"
	source: "[
			Jinny Corp.
			3587 Oakcliff Road, Doraville, GA 30340
			Telephone 770-734-9222, Fax 770-734-0556
			Website http://www.jinny.com
			Customer support http://support.jinny.com
		]"
end
