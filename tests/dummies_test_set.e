note
	description: "[
		Testing based on HTML5 and CSS3 all-in-one for Dummies book.
	]"
	synopsis: "[
		Tests in this test-class represent recreations of pages built in the Dummies book above
		(see EIS to Amazon.com below).
		]"
	EIS: "name=dummies", "protocol=URI", "tag=external",
			"src=http://www.amazon.com/HTML5-CSS3-All-One-Dummies/dp/1118289382"
	testing: "type/manual"

class
	DUMMIES_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	dummies_ch_1_basic_page_test
			-- Basic Page Test
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basicUL_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_4/basicUL.html"
			EIS: "name=basicUL_page_created", "protocol=URI", "tag=local_example",
					"src=file:///$GITHUB/ehtml/tests/output/myFirst.html"
		local
			l_page: DUMMIES_CH_1_BASIC_PAGE
			l_file: RAW_FILE
		do
			create l_page
			assert_strings_equal ("basic_page", basic_page, l_page.html)
			create l_file.make_open_write (".\tests\output\myFirst.html")
			l_file.put_string (l_page.html)
			l_file.close
		end

	dummies_ch_4_basicUL_test
			-- Basic Unorder List Test
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_4/basicUL.html"
			EIS: "name=basic_page_created", "protocol=URI", "tag=local_example",
					"src=file:///$GITHUB/ehtml/tests/output/basicUL.html"
		local
			l_page: DUMMIES_CH_4_BASICUL
			l_file: RAW_FILE
		do
			create l_page
			assert_strings_equal ("basicUL_page", basicUL, l_page.html)
			create l_file.make_open_write (".\tests\output\basicUL.html")
			l_file.put_string (l_page.html)
			l_file.close
		end

	dummies_ch_4_basicOL_test
			-- Basic Ordered List Test
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_4/basicOL.html"
			EIS: "name=basic_page_created", "protocol=URI", "tag=local_example",
					"src=file:///$GITHUB/ehtml/tests/output/basicOL.html"
		local
			l_page: DUMMIES_CH_4_BASICOL
			l_file: RAW_FILE
		do
			create l_page
			assert_strings_equal ("basicOL_page", basicOL, l_page.html)
			create l_file.make_open_write (".\tests\output\basicOL.html")
			l_file.put_string (l_page.html)
			l_file.close
		end

	dummies_ch_4_nested_list
			-- Nested List Test
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_4/nestedList.html"
			EIS: "name=basic_page_created", "protocol=URI", "tag=local_example",
					"src=file:///$GITHUB/ehtml/tests/output/nestedlist.html"
		local
			l_page: DUMMIES_CH_4_NESTED_LIST
			l_file: RAW_FILE
		do
			create l_page
			assert_strings_equal ("nestedlist_page", nested_list, l_page.html)
			create l_file.make_open_write (".\tests\output\nestedlist.html")
			l_file.put_string (l_page.html)
			l_file.close
		end

	dummies_ch_4_definition_list
			-- Definition List Test
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_4/basicDL.html"
			EIS: "name=basic_page_created", "protocol=URI", "tag=local_example",
					"src=file:///$GITHUB/ehtml/tests/output/basicDL.html"
		local
			l_page: DUMMIES_CH_4_DEFINITION_LIST
			l_file: RAW_FILE
		do
			create l_page
			assert_strings_equal ("basicDL_page", basicDL, l_page.html)
			create l_file.make_open_write (".\tests\output\basicDL.html")
			l_file.put_string (l_page.html)
			l_file.close
		end

feature {NONE} -- Test Constants

	basic_page: STRING = "[
<!doctype >
<html lang=en-US>
<head>
	<meta charset="UTF-8"
<!-- myFirst html -->
</head>
<body>
<h1>
This is my first web page!</h1><p>
This is the first web page I've ever made, and I am extremely proud of it. it is so cool!</p></body></html>
]"

	basicUL: STRING = "[
<!doctype >
<html lang=en-US>
<head>
	<meta charset="UTF-8"
<title>basicUL.html</title>
</head>
<body>
<h1>
Basic Lists</h1><h2>
Common Web Browsers</h2><ul>
<li>
Firefox</li><li>
Chrome</li><li>
Internet Explorer</li><li>
Opera</li><li>
Safari</li></ul></body></html>
]"

	basicOL: STRING = "[
<!doctype >
<html lang=en-US>
<head>
	<meta charset="UTF-8"
<title>basicOL.html</title>
</head>
<body>
<h1>
Basic Ordered List</h1><h2>
Top ten dog names in the USA</h2><ul>
<li>
Max</li><li>
Jake</li><li>
Buddy</li><li>
Maggie</li><li>
Bear</li><li>
Molly</li><li>
Bailey</li><li>
Shadow</li><li>
Sam</li><li>
Lady</li></ul><p>
data from http://www.bowwow.com.au</p></body></html>
]"

	nested_list: STRING = "[
<!doctype >
<html lang=en-US>
<head>
	<meta charset="UTF-8"
</head>
<body>
<h1>
Nested Lists</h1><h2>
Popular Cat Names</h2><ul>
<li>
USA

<ol>
<li>
Tigger</li><li>
Tiger</li><li>
Max</li><li>
Smokey</li><li>
Sam</li></ol></li><li>
Australia

<ol>
<li>
Oscar</li><li>
Max</li><li>
Tiger</li><li>
Sam</li><li>
Misty</li></ol></li></ul></body></html>
]"

	basicDL: STRING = "[
<!doctype >
<html lang=en-US>
<head>
	<meta charset="UTF-8"
</head>
<body>
<h1>
Basic Definition List</h1><h2>
Common Web Browsers</h2><dd>
<dt>
Mosaic</dt><dd>
The mother of all modern browsers. The first widely used visual browser.</dd><dt>
Netscape</dt><dd>
The commercial successor to Mosaic. Widely popular, but eventually eclipsed by Internet Explorer</dd><dt>
IE</dt><dd>
Microsoft's entry into the browser market, and a dominant player.</dd><dt>
Firefox</dt><dd>
An open-source browser that has shaken up the world.</dd></dd></body></html>
]"

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


