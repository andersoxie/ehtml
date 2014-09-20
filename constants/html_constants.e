note
	description: "[
		HTML Constants
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONSTANTS

feature -- Constants

	uppercase_a_to_z: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			-- Uppercase A-Z

	lowercase_a_to_z: STRING = "abcdefghijklmnopqrstuvwxyz"
			-- Lowercase a-z

	numeric_digits: STRING = "0123456789"
			-- Numeric digits 0-9

	special_characters: STRING = "-_"
			-- Miscellaneous special characters.

	space_8: CHARACTER_8 = ' '
			-- 8-bit space.

feature -- Constants: Named Boolean Operators

	is_double_quoted: BOOLEAN = True
			-- When something must be wrapped in double-quotes.

	left_angle: CHARACTER_8 = '<'
	right_angle: CHARACTER_8 = '>'
	end_slash: CHARACTER_8 = '/'
	space: CHARACTER_8 = ' '
	newline: CHARACTER_8 = '%N'
	tab: CHARACTER_8 = '%T'

	no_body: STRING = ""

	no_content: detachable STRING

	no_manual_attributes: detachable STRING

	has_end_tag_constant: BOOLEAN = True

	is_self_ending_constant: BOOLEAN = True

	suppress_newlines_constant: BOOLEAN = True

	no_manaul_attributes: detachable STRING
			-- Constants used to indicate how there are no manually determined attributes for the tag under construction.

	no_tag_content: detachable STRING
			-- Constants used to indicate how there are no contents for the tag under construction.

	no_global_attributes: detachable HTML_GLOBAL_ATTRIBUTES
			-- Constants used to indicate how there are no global attributes for the tag under construction.

	yes: BOOLEAN = True
			-- Affirmative.

	no: BOOLEAN
			-- Opposite of `yes'.
		once
			Result := not yes
		end

feature -- Regex

	html_regex: RX_PCRE_MATCHER
			-- <html> pattern matcher.
		once
			Result := start_end_tag_regex (Html_tag_name)
		end

	form_regex: RX_PCRE_MATCHER
			-- <form> pattern matcher.
		once
			Result := start_end_tag_regex (form_tag_name)
		end

	input_regex: RX_PCRE_MATCHER
			-- <input> pattern matcher.
		once
			Result := start_end_tag_regex (input_tag_name)
		end

	head_regex: RX_PCRE_MATCHER
			-- <head> pattern matcher.
		once
			Result := start_end_tag_regex (head_tag_name)
		end

	title_regex: RX_PCRE_MATCHER
			-- <title> pattern matcher.
		once
			Result := start_end_tag_regex (title_tag_name)
		end

	paragraph_regex: RX_PCRE_MATCHER
			-- <paragraph> pattern matcher.
		once
			Result := start_end_tag_regex (paragraph_tag_name)
		end

feature {HTML_FACTORY} -- Implementation: Regex

	start_end_tag_regex (a_tag: STRING): RX_PCRE_MATCHER
			-- Given both a <[a_tag]> and </[a_tag]> tag structure, compile for `a_tag'
		local
			l_tag: STRING
		do
			create Result.make
			Result.set_case_insensitive (True)
				-- Create regex expression to compile from `a_tag'
			l_tag := "<"
			l_tag.append_string (a_tag)
			l_tag.append_string ("\b[^>]*>(*?)</")
			l_tag.append_string (a_tag)
			l_tag.append_character ('>')
			Result.compile (l_tag)
		ensure
			compiles: Result.is_compiled
		end

feature -- Constants: Tag names

	get_method_name: STRING = "GET"

	post_method_name: STRING = "POST"

	html_tag_name: STRING = "html"

	body_tag_name: STRING = "body"

	form_tag_name: STRING = "form"

	input_tag_name: STRING = "input"

	paragraph_tag_name: STRING = "p"

	head_tag_name: STRING = "head"

	title_tag_name: STRING = "title"

	op_parameter_keyword: STRING = "op"
			-- Keyword for "op" (operation) parameter.

	quit_operation_keyword: STRING = "quit"
			-- Keyword for "quit" parameter.

feature -- Codes

	english_code: STRING
			-- English language code.
		once
			check has_code: attached language_codes.at (english_key) as al_code then
				Result := al_code
			end
		end

	english_key: STRING = "English"

	language_codes: HASH_TABLE [STRING, STRING]
			-- Hash of valid language codes.
		once
			create Result.make (145)
			Result.force ("ab", "Abkhazian")
			Result.force ("aa", "Afar")
			Result.force ("af", "Afrikaans")
			Result.force ("sq", "Albanian")
			Result.force ("am", "Amharic")
			Result.force ("ar", "Arabic")
			Result.force ("an", "Aragonese")
			Result.force ("hy", "Armenian")
			Result.force ("as", "Assamese")
			Result.force ("ay", "Aymara")
			Result.force ("az", "Azerbaijani")
			Result.force ("ba", "Bashkir")
			Result.force ("eu", "Basque")
			Result.force ("bn", "Bengali")
			Result.force ("dz", "Bhutani")
			Result.force ("bh", "Bihari")
			Result.force ("bi", "Bislama")
			Result.force ("br", "Breton")
			Result.force ("bg", "Bulgarian")
			Result.force ("my", "Burmese")
			Result.force ("be", "Byelorussian")
			Result.force ("km", "Cambodian")
			Result.force ("ca", "Catalan")
			Result.force ("zh", "Chinese")
			Result.force ("co", "Corsican")
			Result.force ("hr", "Croatian")
			Result.force ("cs", "Czech")
			Result.force ("da", "Danish")
			Result.force ("nl", "Dutch")
			Result.force ("en", english_key)
			Result.force ("eo", "Esperanto")
			Result.force ("et", "Estonian")
			Result.force ("fo", "Faeroese")
			Result.force ("fa", "Farsi")
			Result.force ("fj", "Fiji")
			Result.force ("fi", "Finnish")
			Result.force ("fr", "French")
			Result.force ("fy", "Frisian")
			Result.force ("gl", "Galician")
			Result.force ("gd", "Gaelic")
			Result.force ("gv", "Gaelicm")
			Result.force ("ka", "Georgian")
			Result.force ("de", "German")
			Result.force ("el", "Greek")
			Result.force ("kl", "Greenlandic")
			Result.force ("gn", "Guarani")
			Result.force ("gu", "Gujarati")
			Result.force ("ht", "HaitianCreole")
			Result.force ("ha", "Hausa")
			Result.force ("he", "Hebrew")
			Result.force ("hi", "Hindi")
			Result.force ("hu", "Hungarian")
			Result.force ("is", "Icelandic")
			Result.force ("io", "Ido")
			Result.force ("id", "Indonesian")
			Result.force ("ia", "Interlingua")
			Result.force ("ie", "Interlingue")
			Result.force ("iu", "Inuktitut")
			Result.force ("ik", "Inupiak")
			Result.force ("ga", "Irish")
			Result.force ("it", "Italian")
			Result.force ("ja", "Japanese")
			Result.force ("jv", "Javanese")
			Result.force ("kn", "Kannada")
			Result.force ("ks", "Kashmiri")
			Result.force ("kk", "Kazakh")
			Result.force ("rw", "Kinyarwanda")
			Result.force ("ky", "Kirghiz")
			Result.force ("rn", "Kirundi")
			Result.force ("ko", "Korean")
			Result.force ("ku", "Kurdish")
			Result.force ("lo", "Laothian")
			Result.force ("la", "Latin")
			Result.force ("lv", "Latvian")
			Result.force ("li", "Limburgish")
			Result.force ("ln", "Lingala")
			Result.force ("lt", "Lithuanian")
			Result.force ("mk", "Macedonian")
			Result.force ("mg", "Malagasy")
			Result.force ("ms", "Malay")
			Result.force ("ml", "Malayalam")
			Result.force ("mt", "Maltese")
			Result.force ("mi", "Maori")
			Result.force ("mr", "Marathi")
			Result.force ("mo", "Moldavian")
			Result.force ("mn", "Mongolian")
			Result.force ("na", "Nauru")
			Result.force ("ne", "Nepali")
			Result.force ("no", "Norwegian")
			Result.force ("oc", "Occitan")
			Result.force ("or", "Oriya")
			Result.force ("om", "Oromo")
			Result.force ("ps", "Pashto")
			Result.force ("pl", "Polish")
			Result.force ("pt", "Portuguese")
			Result.force ("pa", "Punjabi")
			Result.force ("qu", "Quechua")
			Result.force ("rm", "RhaetoRomance")
			Result.force ("ro", "Romanian")
			Result.force ("ru", "Russian")
			Result.force ("sm", "Samoan")
			Result.force ("sg", "Sangro")
			Result.force ("sa", "Sanskrit")
			Result.force ("sr", "Serbian")
			Result.force ("sh", "SerboCroatian")
			Result.force ("st", "Sesotho")
			Result.force ("tn", "Setswana")
			Result.force ("sn", "Shona")
			Result.force ("Yi", "Sichuan")
			Result.force ("sd", "Sindhi")
			Result.force ("si", "Sinhalese")
			Result.force ("ss", "Siswati")
			Result.force ("sk", "Slovak")
			Result.force ("sl", "Slovenian")
			Result.force ("so", "Somali")
			Result.force ("es", "Spanish")
			Result.force ("su", "Sundanese")
			Result.force ("sw", "Swahili")
			Result.force ("sv", "Swedish")
			Result.force ("tl", "Tagalog")
			Result.force ("tg", "Tajik")
			Result.force ("ta", "Tamil")
			Result.force ("tt", "Tatar")
			Result.force ("te", "Telugu")
			Result.force ("th", "Thai")
			Result.force ("bo", "Tibetan")
			Result.force ("ti", "Tigrinya")
			Result.force ("to", "Tonga")
			Result.force ("ts", "Tsonga")
			Result.force ("tr", "Turkish")
			Result.force ("tk", "Turkmen")
			Result.force ("tw", "Twi")
			Result.force ("ug", "Uighur")
			Result.force ("uk", "Ukrainian")
			Result.force ("ur", "Urdu")
			Result.force ("uz", "Uzbek")
			Result.force ("vi", "Vietnamese")
			Result.force ("vo", "Volapük")
			Result.force ("wa", "Wallon")
			Result.force ("cy", "Welsh")
			Result.force ("wo", "Wolof")
			Result.force ("xh", "Xhosa")
			Result.force ("yi", "Yiddish")
			Result.force ("yo", "Yoruba")
			Result.force ("zu", "Zulu")
		ensure
			valid_count: Result.count = 145
		end

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
