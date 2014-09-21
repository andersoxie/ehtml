note
	description: "[
		Representation of an HTML Helper
		]"
	author: "Larry Rix"
	purpose: "[
		To provide HTML helper routines to any class needing them.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_HELPER 

inherit
	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		end

feature -- Basic Operations

	url_encoded_string (a_unencoded_string: READABLE_STRING_32): STRING_8
			-- Encode `a_unencoded_string' with percents as needed.
		do
			create Result.make (a_unencoded_string.count)
			url_encoder.append_percent_encoded_string_to (a_unencoded_string, Result)
		end

	html_decoded_string (a_html_undecoded_string: READABLE_STRING_32): READABLE_STRING_32
			-- Decode `a_html_undecoded_string' (i.e. can one convert `arg' to CHAR_8 without dataloss?)
		do
			if a_html_undecoded_string.is_valid_as_string_8 then
				Result := (create {HTML_ENCODER}).decoded_string (a_html_undecoded_string)
			else
				Result := a_html_undecoded_string
			end
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
