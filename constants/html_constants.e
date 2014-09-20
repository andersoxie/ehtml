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

	english_code: STRING = "en"

	no_body: STRING = ""

	no_content: detachable STRING

	no_manual_attributes: detachable STRING

	has_end_tag: BOOLEAN = True

	is_self_ending: BOOLEAN = True

	suppress_newlines: BOOLEAN = True

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

	language_codes: HASH_TABLE [STRING, STRING]
			-- Hash of valid language codes.
		once
			create Result.make (145)
			Result.force ("Abkhazian", "ab")
			Result.force ("Afar", "aa")
			Result.force ("Afrikaans", "af")
			Result.force ("Albanian", "sq")
			Result.force ("Amharic", "am")
			Result.force ("Arabic", "ar")
			Result.force ("Aragonese", "an")
			Result.force ("Armenian", "hy")
			Result.force ("Assamese", "as")
			Result.force ("Aymara", "ay")
			Result.force ("Azerbaijani", "az")
			Result.force ("Bashkir", "ba")
			Result.force ("Basque", "eu")
			Result.force ("Bengali", "bn")
			Result.force ("Bhutani", "dz")
			Result.force ("Bihari", "bh")
			Result.force ("Bislama", "bi")
			Result.force ("Breton", "br")
			Result.force ("Bulgarian", "bg")
			Result.force ("Burmese", "my")
			Result.force ("Byelorussian", "be")
			Result.force ("Cambodian", "km")
			Result.force ("Catalan", "ca")
			Result.force ("Chinese", "zh")
			Result.force ("Corsican", "co")
			Result.force ("Croatian", "hr")
			Result.force ("Czech", "cs")
			Result.force ("Danish", "da")
			Result.force ("Dutch", "nl")
			Result.force ("English", "en")
			Result.force ("Esperanto", "eo")
			Result.force ("Estonian", "et")
			Result.force ("Faeroese", "fo")
			Result.force ("Farsi", "fa")
			Result.force ("Fiji", "fj")
			Result.force ("Finnish", "fi")
			Result.force ("French", "fr")
			Result.force ("Frisian", "fy")
			Result.force ("Galician", "gl")
			Result.force ("Gaelic", "gd")
			Result.force ("Gaelic-m", "gv")
			Result.force ("Georgian", "ka")
			Result.force ("German", "de")
			Result.force ("Greek", "el")
			Result.force ("Greenlandic", "kl")
			Result.force ("Guarani", "gn")
			Result.force ("Gujarati", "gu")
			Result.force ("Haitian Creole", "ht")
			Result.force ("Hausa", "ha")
			Result.force ("Hebrew", "he")
			Result.force ("Hindi", "hi")
			Result.force ("Hungarian", "hu")
			Result.force ("Icelandic", "is")
			Result.force ("Ido", "io")
			Result.force ("Indonesian", "id")
			Result.force ("Interlingua", "ia")
			Result.force ("Interlingue", "ie")
			Result.force ("Inuktitut", "iu")
			Result.force ("Inupiak", "ik")
			Result.force ("Irish", "ga")
			Result.force ("Italian", "it")
			Result.force ("Japanese", "ja")
			Result.force ("Javanese", "jv")
			Result.force ("Kannada", "kn")
			Result.force ("Kashmiri", "ks")
			Result.force ("Kazakh", "kk")
			Result.force ("Kinyarwanda", "rw")
			Result.force ("Kirghiz", "ky")
			Result.force ("Kirundi (Rundi)", "rn")
			Result.force ("Korean", "ko")
			Result.force ("Kurdish", "ku")
			Result.force ("Laothian", "lo")
			Result.force ("Latin", "la")
			Result.force ("Latvian", "lv")
			Result.force ("Limburgish", "li")
			Result.force ("Lingala", "ln")
			Result.force ("Lithuanian", "lt")
			Result.force ("Macedonian", "mk")
			Result.force ("Malagasy", "mg")
			Result.force ("Malay", "ms")
			Result.force ("Malayalam", "ml")
			Result.force ("Maltese", "mt")
			Result.force ("Maori", "mi")
			Result.force ("Marathi", "mr")
			Result.force ("Moldavian", "mo")
			Result.force ("Mongolian", "mn")
			Result.force ("Nauru", "na")
			Result.force ("Nepali", "ne")
			Result.force ("Norwegian", "no")
			Result.force ("Occitan", "oc")
			Result.force ("Oriya", "or")
			Result.force ("Oromo", "om")
			Result.force ("Pashto (Pushto)", "ps")
			Result.force ("Polish", "pl")
			Result.force ("Portuguese", "pt")
			Result.force ("Punjabi", "pa")
			Result.force ("Quechua", "qu")
			Result.force ("Rhaeto-Romance", "rm")
			Result.force ("Romanian", "ro")
			Result.force ("Russian", "ru")
			Result.force ("Samoan", "sm")
			Result.force ("Sangro", "sg")
			Result.force ("Sanskrit", "sa")
			Result.force ("Serbian", "sr")
			Result.force ("Serbo-Croatian", "sh")
			Result.force ("Sesotho", "st")
			Result.force ("Setswana", "tn")
			Result.force ("Shona", "sn")
			Result.force ("Sichuan", "Yi")
			Result.force ("Sindhi", "sd")
			Result.force ("Sinhalese", "si")
			Result.force ("Siswati", "ss")
			Result.force ("Slovak", "sk")
			Result.force ("Slovenian", "sl")
			Result.force ("Somali", "so")
			Result.force ("Spanish", "es")
			Result.force ("Sundanese", "su")
			Result.force ("Swahili", "sw")
			Result.force ("Swedish", "sv")
			Result.force ("Tagalog", "tl")
			Result.force ("Tajik", "tg")
			Result.force ("Tamil", "ta")
			Result.force ("Tatar", "tt")
			Result.force ("Telugu", "te")
			Result.force ("Thai", "th")
			Result.force ("Tibetan", "bo")
			Result.force ("Tigrinya", "ti")
			Result.force ("Tonga", "to")
			Result.force ("Tsonga", "ts")
			Result.force ("Turkish", "tr")
			Result.force ("Turkmen", "tk")
			Result.force ("Twi", "tw")
			Result.force ("Uighur", "ug")
			Result.force ("Ukrainian", "uk")
			Result.force ("Urdu", "ur")
			Result.force ("Uzbek", "uz")
			Result.force ("Vietnamese", "vi")
			Result.force ("Volapük", "vo")
			Result.force ("Wallon", "wa")
			Result.force ("Welsh", "cy")
			Result.force ("Wolof", "wo")
			Result.force ("Xhosa", "xh")
			Result.force ("Yiddish", "yi")
			Result.force ("Yoruba", "yo")
			Result.force ("Zulu", "zu")
		ensure
			valid_count: Result.count = 145
		end

end
