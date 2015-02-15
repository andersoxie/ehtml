note
	description: "Summary description for {TEST_REDIRECTION_RESPONSE_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REDIRECTION_RESPONSE_PAGE

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

	body_content (a_username, a_target_url: STRING; a_delay: INTEGER): STRING
			-- Page body HTML with `a_username'.
		do
			Result := "Bye "
			Result.append_string (a_username)
			Result.append_string (",<br/> see you soon.")
			Result.append_string (factory.paragraph ("You will be redirected to " + a_target_url + " in " + a_delay.out + " second(s) ..."))
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
