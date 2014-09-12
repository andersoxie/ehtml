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
			l_misc: TUPLE [INTEGER, STRING, ARRAY [ANY]]
			l_array: ARRAYED_LIST [INTEGER]
		do
			create l_test										-- Test of creation and post-creation invariant.
			l_test.set_class_attribute_value ("Test_Class-1")	-- Test of invariant, post-setting of "class" attribute.
--			l_misc.item (1)
--			l_misc [1]
			create l_misc
			l_misc [1] := 50
			l_misc [2] := "Bugs"
			l_misc [3] := <<1, 2, 3>>
			create l_array.make_from_array (<<1, 2, 3>>)
			if attached (l_misc @ 1) as al_value then
				print (al_value.out)
			end
		end

feature {NONE} -- Implementation

	my_feature (a_data: TUPLE): TUPLE
		do
			create Result
		end

end


