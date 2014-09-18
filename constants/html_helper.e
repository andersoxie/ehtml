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

end
