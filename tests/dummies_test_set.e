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

	basic_page_test
			-- Page #10 "Basic Page"
		note
			testing:  "execution/isolated"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio"
			EIS: "name=basic_page", "protocol=URI", "tag=example",
					"src=http://www.aharrisbooks.net/haio/book_1/chap_1/myFirst.html"
		local
			l_page: MOCK_BASIC_PAGE
		do
			create l_page
			assert_strings_equal ("basic_page", basic_page, l_page.html)
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


