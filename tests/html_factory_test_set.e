note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTML_FACTORY_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_basic_html_page_creation
			-- Test to prove a standard HTML page can be created.
		local
			l_html_factory: HTML_FACTORY
		do
			create l_html_factory
			assert_strings_equal ("html_page", most_basic_html_page_in_english, l_html_factory.html_page (no_body, english_code))
		end

	test_css_slidy_page_creation
			-- Test to prove successful generation of the CSS Slidy example HTML.
		local
			l_factory: HTML_FACTORY
			l_page,
			l_title,
			l_head,
			l_head_content,
			l_link,
			l_meta,
			l_img_1, l_img_2, l_img_3, l_img_4: STRING
		do
			create l_factory

				-- Build: <title>CSSslidy</title>
			l_title := l_factory.tag_with_contents ("title", no_manual_attributes, "CSSslidy", no_global_attributes, has_end_tag, not is_self_ending, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("title_tag", "<title>CSSslidy<\title>", l_title)

				-- Build: <link rel="stylesheet" href="styles.css">
			l_link := l_factory.tag_with_contents ("link", "rel=%"stylesheet%" href=%"styles.css%"", no_content, no_global_attributes, not has_end_tag, not is_self_ending, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("link_tag", "<link rel=%"stylesheet%" href=%"styles.css%">", l_link)

				-- Build: <meta charset=utf-8>
			l_meta := l_factory.tag_with_contents ("meta", "charset=utf-8", no_content, no_global_attributes, not has_end_tag, not is_self_ending, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("meta_tag", "<meta charset=utf-8>", l_meta)

				-- <head> ... </head> see `slidy_head_with_content'.
			l_head_content := l_factory.build_content_as_indented_newlines (<<l_title, l_link, l_meta>>)
			l_head := l_factory.tag_with_contents ("head", no_manual_attributes, l_head_content, no_global_attributes, has_end_tag, not is_self_ending, not suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("head", slidy_head_with_content, l_head)

				-- Build: <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg" alt="Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj" data-caption="Antelope Canyon, Arizona">
			l_factory.set_data_attribute (["caption" ,"Antelope Canyon, Arizona"], "caption-antelope-canyon-arizona")
			l_img_1 := l_factory.tag_with_contents ("img", "src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%"", no_content, l_factory, not has_end_tag, not is_self_ending, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("img_1", img_1, l_img_1)
		end

feature {NONE} -- Implementation: Constants

	english_code: STRING = "en"

	no_body: STRING = ""

	no_content: detachable STRING

	no_manual_attributes: detachable STRING

	no_global_attributes: detachable HTML_GLOBAL_ATTRIBUTES

	has_end_tag: BOOLEAN = True

	is_self_ending: BOOLEAN = True

	suppress_newlines: BOOLEAN = True

	most_basic_html_page_in_english: STRING = "[
<!doctype html>
<html lang=en>
<\html>
]"

	slidy_head_with_content: STRING = "[
<head>
	<title>CSSslidy<\title>
	<link rel="stylesheet" href="styles.css">
	<meta charset=utf-8>
<\head>
]"

	img_1: STRING ="<img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%" data-caption=%"Antelope Canyon, Arizona%">"
		--          <img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%">
end


