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
			assert_strings_equal ("html_page", most_basic_html_page_in_english, l_html_factory.html_page (no_body, english_code, "html"))
		end

	test_css_slidy_page_creation
			-- Test to prove successful generation of the CSS Slidy example HTML.
		note
			how: "[
				By producing the HTML5 index page that duplicates the CSS Slidy example. This file
				is generated in the test and then written to the docs directory. Run that file to
				finally prove that the HTML generation was successful.
				]"
		local
			l_factory: HTML_FACTORY
			l_page,
			l_content,
			l_body,
			l_title,
			l_head,
			l_head_content,
			l_link,
			l_meta,
			l_img_1, l_img_2, l_img_3, l_img_4,
			l_figure,
			l_figure_content,
			l_div,
			l_script_1,
			l_script_2: STRING
			l_index_html: PLAIN_TEXT_FILE
		do
			create l_factory

				-- Build: <title>CSSslidy</title>
			l_title := l_factory.tag_contented ("title", no_manual_attributes, "CSSslidy", no_global_attributes, has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("title_tag", "<title>CSSslidy</title>", l_title)

				-- Build: <link rel="stylesheet" href="styles.css">
			l_link := l_factory.tag_contented ("link", "rel=%"stylesheet%" href=%"styles.css%"", no_content, no_global_attributes, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("link_tag", "<link rel=%"stylesheet%" href=%"styles.css%"/>", l_link)

				-- Build: <meta charset=utf-8>
			l_meta := l_factory.tag_contented ("meta", "charset=utf-8", no_content, no_global_attributes, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("meta_tag", "<meta charset=utf-8/>", l_meta)

				-- <head> ... </head> see `slidy_head_with_content'.
			l_head_content := l_factory.build_content_as_indented_newlines (<<l_title, l_link, l_meta>>)
			l_head := l_factory.tag_contented ("head", no_manual_attributes, l_head_content, no_global_attributes, has_end_tag, not suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("head", slidy_head_with_content, l_head)

				-- Build: <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg" alt="Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj" data-caption="Antelope Canyon, Arizona">
			create l_factory
			l_factory.set_data_attribute (["caption" ,"Antelope Canyon, Arizona"], "caption-antelope-canyon-arizona")
			l_img_1 := l_factory.tag_contented ("img", "src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%"", no_content, l_factory, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("img_1", img_1, l_img_1)

				-- Build: <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/canyonlands.jpg" alt="Broad vista photograph of Canyonlands National Park, Arizona, taken by Charles Martin" data-caption="Canyonlands Vista, Arizona" >
			create l_factory
			l_factory.set_data_attribute (["caption" ,"Canyonlands Vista, Arizona"], "caption-antelope-canyon-arizona")
			l_img_2 := l_factory.tag_contented ("img", "src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/canyonlands.jpg%" alt=%"Broad vista photograph of Canyonlands National Park, Arizona, taken by Charles Martin%"", no_content, l_factory, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("img_2", img_2, l_img_2)

				-- Build: <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/mesa-arch.jpg" alt="Photograph looking through Mesa Arch at a sunrise in Moab, Utah, taken by Krasimir Ganchev" data-caption="Mesa Arch sunrise, Moab, Utah">
			create l_factory
			l_factory.set_data_attribute (["caption" ,"Mesa Arch sunrise, Moab, Utah"], "caption-antelope-canyon-arizona")
			l_img_3 := l_factory.tag_contented ("img", "src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/mesa-arch.jpg%" alt=%"Photograph looking through Mesa Arch at a sunrise in Moab, Utah, taken by Krasimir Ganchev%"", no_content, l_factory, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("img_3", img_3, l_img_3)

				-- Build: <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/wave-canyon.jpg" alt="Photograph of wave rock formations in Canyonlands National Park, Arizona, taken by Vanessa Kay" data-caption="Canyonlands, Arizona">
			create l_factory
			l_factory.set_data_attribute (["caption" ,"Canyonlands, Arizona"], "caption-antelope-canyon-arizona")
			l_img_4 := l_factory.tag_contented ("img", "src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/wave-canyon.jpg%" alt=%"Photograph of wave rock formations in Canyonlands National Park, Arizona, taken by Vanessa Kay%"", no_content, l_factory, not has_end_tag, suppress_newlines)
				-- ... and test ...
			assert_strings_equal ("img_4", img_4, l_img_4)

			create l_factory
			l_figure_content := l_factory.build_content_as_indented_newlines (<<l_img_1, l_img_2, l_img_3, l_img_4>>)
			l_figure := l_factory.tag_contented ("figure", "id=%"slidy%"", l_figure_content, no_global_attributes, has_end_tag, not suppress_newlines)

			l_div := l_factory.tag_contented ("div", "id=%"slidy-container%"", l_figure, no_global_attributes, not has_end_tag, not suppress_newlines)

			l_script_1 := l_factory.tag_contented ("script", "src=%"cssslidy.js%"", no_content, no_global_attributes, has_end_tag, suppress_newlines)
			l_script_2 := l_factory.tag_contented ("script", Void, "cssSlidy();", no_global_attributes, has_end_tag, suppress_newlines)

			l_body := l_div.twin
			l_body.append_character ('%N')
			l_body.append_string (l_script_1)
			l_body.append_character ('%N')
			l_body.append_string (l_script_2)
			l_body.append_character ('%N')

			l_content := l_factory.indent_one_level_and_then_newline (l_head)
			l_content.append_string (l_factory.indent_one_level_and_then_newline (l_body))
			l_page := l_factory.html_page (l_content, "en", Void)

			create l_index_html.make_create_read_write (".\docs\CSSslidy-gh-pages\index_generated_for_testing.html")
			l_index_html.put_string (l_page)
			l_index_html.close
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
</html>
]"

	slidy_head_with_content: STRING = "[
<head>
	<title>CSSslidy</title>
	<link rel="stylesheet" href="styles.css"/>
	<meta charset=utf-8/>
</head>
]"

	img_1: STRING ="<img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%" data-caption=%"Antelope Canyon, Arizona%"/>"
		--          <img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/antelope-canyon.jpg%" alt=%"Photograph of orange rock formations in Antelope Canyon, Arizona by eliyasj%">

	img_2: STRING ="<img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/canyonlands.jpg%" alt=%"Broad vista photograph of Canyonlands National Park, Arizona, taken by Charles Martin%" data-caption=%"Canyonlands Vista, Arizona%"/>"
		-- 			<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/canyonlands.jpg" alt="Broad vista photograph of Canyonlands National Park, Arizona, taken by Charles Martin" data-caption="Canyonlands Vista, Arizona" >

	img_3: STRING ="<img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/mesa-arch.jpg%" alt=%"Photograph looking through Mesa Arch at a sunrise in Moab, Utah, taken by Krasimir Ganchev%" data-caption=%"Mesa Arch sunrise, Moab, Utah%"/>"
		-- 			<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/mesa-arch.jpg" alt="Photograph looking through Mesa Arch at a sunrise in Moab, Utah, taken by Krasimir Ganchev" data-caption="Mesa Arch sunrise, Moab, Utah">

	img_4: STRING ="<img src=%"https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/wave-canyon.jpg%" alt=%"Photograph of wave rock formations in Canyonlands National Park, Arizona, taken by Vanessa Kay%" data-caption=%"Canyonlands, Arizona%"/>"
		-- 			<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/wave-canyon.jpg" alt="Photograph of wave rock formations in Canyonlands National Park, Arizona, taken by Vanessa Kay" data-caption="Canyonlands, Arizona">

end


