note
	description: "[
		Library Documentation Examples
		]"
	purpose: "[
		To provide a centralized point of beginning for accessing and learning the eHTML library.
		]"
	how: "[
		By providing a number of accessor features with TUPLE [how_to, example]
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOC_LIBRARY_EXAMPLES

--feature -- Primary Documentation

--	primary_library_documentation: detachable DOC_LIBRARY_EHTML
--			-- The primary starting point for understanding and learning about this library.

--feature -- How-to's

--	global_attributes_how_to: detachable TUPLE [how_to: GLOBAL_ATTRIBUTES_TEST_SET; example: HTML_GLOBAL_ATTRIBUTES]
--			-- Use this TEST_SET class as a guide for using HTML5 Global Attributes.
--		note
--			description: "[
--				Every HTML-5 element (tag) has a shared collection of attributes, following the BNF-E
--				specification below and the example.
--				]"
--			example: "[
--				<Element_name [{}Attribute_name="Value"|Value}*]>
--				]"
--			BNFE: "[
--				Html_element ::=
--					"<" Element_name Attribute_list ">"
--					
--				Element_name ::=
--					{a .. z} | {A .. Z} | {"_" | "-"}
--				
--				(*must start with A-Z|a-z and the remaining characters must conform to
--					A-Z|a-z|0-9|"_"|"-" and cannot be empty.*)
--					
--				Attribute_list ::=
--					{Attribute}*
--					
--				Attribute ::=
--					Attribute_name "=" [Double_quote] Value [Double_quote]
--					
--				Attribute_name ::=
--					{a .. z} | {A .. Z} | {"_" | "-"}
--					
--				Double_quote ::= `"'
--				]"
--			EIS: "name=BNF-E", "src=http://en.wikipedia.org/wiki/Extended_Backus%%E2%%80%%93Naur_Form", "protocol=URI"
--		do
--			Result := Void
--		end

--	color_constants_how_to: detachable TUPLE [how_to: HTML_COLOR_CONSTANTS_TEST_SET; example: HTML_COLOR_CONSTANTS]
--			-- Use this TEST_SET class as a guide for using HTML_COLOR_CONSTANTS.
--		note
--			description: "[
--				Color constants provide access to all of the predefined (named) colors in the HTML-5
--				universe.
--				]"
--		do
--			Result := Void
--		end

--	html_factory_how_to: detachable TUPLE [how_to: HTML_FACTORY_TEST_SET; example: HTML_FACTORY]
--			-- Use this TEST_SET class as a guide for using the {HTML_FACTORY} at a root-level (i.e. not a framework).
--		note
--			description: "[
--				The HTML_FACTORY is the core class for on-the-fly HTML generation in this library.
--				]"
--		do
--			Result := Void
--		end

end
