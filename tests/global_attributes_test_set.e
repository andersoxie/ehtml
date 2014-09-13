note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GLOBAL_ATTRIBUTES_TEST_SET

inherit
	TEST_SET_HELPER

feature -- Test routines

	test_global_attributes
			-- Test creation and modification of global attributes.
		note
			how: "[
				Note how this test follows the theory "Testing begins with Typeing and then Contracts".
					This means that the first line of defense in any correctness system is the compiler
					together with good design and Code Analysis (e.g. Eiffel Inspector). This is immediately
					followed by code Contracts, which can only be exercised dynamically (vs. static for
					the compiler and Eiffel Inspector). Therefore, the following test demonstrates how both
					creation and feature call(s) exercise the results of the compiler and the contracts
					written into the code. Based on this, there is no subsequent need to write assertion
					tests to prove what is already proven by the compiler, Eiffel Inspector, or executed
					contract code. This is the marriage of TDD, BDD, and CDD.
				]"
			glossary: "[
				A glossary of terms.
				]",
				"TDD", "Test Driven Development", "[
					Test-driven development (TDD) is a software development process that relies on the repetition of a very short 
						development cycle: first the developer writes an (initially failing) automated test case that defines a 
						desired improvement or new function, then produces the minimum amount of code to pass that test, and finally 
						refactors the new code to acceptable standards. Kent Beck, who is credited with having developed or 'rediscovered' 
						the technique, stated in 2003 that TDD encourages simple designs and inspires confidence.
					Test-driven development is related to the test-first programming concepts of extreme programming, begun in 
						1999, but more recently has created more general interest in its own right.
					Programmers also apply the concept to improving and debugging legacy code developed with older techniques.
					]",
				"BDD", "Behavior Driven Development", "[
					In software engineering, behavior-driven development (abbreviated BDD) is a software development process based 
						on test-driven development (TDD). Behavior-driven development combines the general techniques and 
						principles of TDD with ideas from domain-driven design and object-oriented analysis and design to provide 
						software development and management teams with shared tools and a shared process to collaborate on software 
						development.
					Although BDD is principally an idea about how software development should be managed by both business interests
						and technical insight, the practice of BDD does assume the use of specialized software tools to support the
						development process. Although these tools are often developed specifically for use in BDD projects, they 
						can be seen as specialized forms of the tooling that supports test-driven development. The tools serve to 
						add automation to the ubiquitous language that is a central theme of BDD.
					]",
				"CDD", "Contract Driven Development", "[
					Although unit tests are recognized as an important tool in software development, programmers prefer 
						to write code, rather than unit tests. Despite the emergence of tools like JUnit which automate part of 
						the process, unit testing remains a time-consuming, resource-intensive, and not particularly appealing 
						activity. This paper introduces a new development method, called Contract Driven Development. This 
						development method is based on a novel mechanism that extracts test cases from failure-producing runs 
						that the programmers trigger. It exploits actions that developers perform anyway as part of their normal 
						process of writing code. Thus, it takes the task of writing unit tests off the developers’ shoulders, 
						while still taking advantage of their knowledge of the intended semantics and structure of the code. 
						The approach is based on the presence of contracts in code, which act as the oracle of the test cases.
						The test cases are extracted completely automatically, are run in the background, and can easily be 
						maintained over versions. The tool implementing this methodology is called Cdd and is available both 
						in binary and in source form.
					]"
		local
			l_test: TEST_ELEMENT
		do
			create l_test
			l_test.set_class_attribute_value ("Test_Class-1")
			assert_strings_equal ("class_attribute", "class=%"Test_Class-1%"", l_test.class_attribute)
			l_test.set_access_key_attribute_value ("h")
			assert_strings_equal ("access_key_attribute", "accesskey=%"h%"", l_test.access_key_attribute)
			l_test.set_content_editable_attribute_value (True)
			assert_strings_equal ("content_editable_attribute", "contenteditable=%"true%"", l_test.content_editable_attribute)
			l_test.set_draggable_attribute_value (True)
			assert_strings_equal ("draggable_attribute", "draggable=%"true%"", l_test.draggable_attribute)
			l_test.set_data_attribute (["attribute-type", "bird"], "attribute_type_bird")
			l_test.set_data_attribute (["attribute-type", "fish"], "attribute_type_fish")
			l_test.set_data_attribute (["attribute-type", "spider"], "attribute_type_spider")
			assert_strings_equal ("attribute_type_bird", "data-attribute-type=%"bird%"", l_test.data_attribute_for_key ("attribute_type_bird"))
			assert_strings_equal ("attribute_type_fish", "data-attribute-type=%"fish%"", l_test.data_attribute_for_key ("attribute_type_fish"))
			assert_strings_equal ("attribute_type_spider", "data-attribute-type=%"spider%"", l_test.data_attribute_for_key ("attribute_type_spider"))
			assert_strings_equal ("attribute_dir_ltr", "dir=%"ltr%"", l_test.dir_left_to_right_attribute)
			assert_strings_equal ("attribute_dir_rtl", "dir=%"rtl%"", l_test.dir_right_to_left_attribute)
			assert_strings_equal ("attribute_dir_auto", "dir=%"auto%"", l_test.dir_auto_attribute)
			assert_strings_equal ("attribute_dir_ltr", "dir=%"ltr%"", l_test.dir_attribute_for_indicator (l_test.left_to_right_identifier))
			assert_strings_equal ("attribute_dir_rtl", "dir=%"rtl%"", l_test.dir_attribute_for_indicator (l_test.right_to_left_identifier))
			assert_strings_equal ("attribute_dir_auto", "dir=%"auto%"", l_test.dir_attribute_for_indicator (l_test.auto_identifier))
			l_test.set_dir_attribute_value (l_test.auto_identifier)
			assert_strings_equal ("dir_auto", "dir=%"auto%"", l_test.dir_attribute)
			l_test.set_dir_left_to_right
			assert_strings_equal ("dir_ltr", "dir=%"ltr%"", l_test.dir_attribute)
			l_test.set_dir_right_to_left
			assert_strings_equal ("dir_rtl", "dir=%"rtl%"", l_test.dir_attribute)
			l_test.reset_dir_attribute_value
			assert_strings_equal ("all_attributes", "accesskey=%"h%" class=%"Test_Class-1%" contenteditable=%"true%"  draggable=%"true%" color:initial data-attribute-type=%"bird%"", l_test.attributes_with_data ("attribute_type_bird"))
			assert_strings_equal ("all_attributes", "accesskey=%"h%" class=%"Test_Class-1%" contenteditable=%"true%"  draggable=%"true%" color:initial data-attribute-type=%"fish%"", l_test.attributes_with_data ("attribute_type_fish"))
			l_test.set_dropzone_copy
			assert_strings_equal ("dropzone_copy", "dropzone=%"copy%"", l_test.dropzone_attribute)
			l_test.set_dropzone_link
			assert_strings_equal ("dropzone_link", "dropzone=%"link%"", l_test.dropzone_attribute)
			l_test.set_dropzone_move
			assert_strings_equal ("dropzone_move", "dropzone=%"move%"", l_test.dropzone_attribute)
			l_test.reset_dropzone_attribute_value
			assert_strings_equal ("all_attributes", "accesskey=%"h%" class=%"Test_Class-1%" contenteditable=%"true%"  draggable=%"true%" color:initial data-attribute-type=%"spider%"", l_test.attributes_with_data ("attribute_type_spider"))
			assert_strings_equal ("inline_style", "color:initial", l_test.inline_style.color_attribute)
		end

end
