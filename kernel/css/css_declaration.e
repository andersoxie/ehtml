note
	description: "[
		CSS Style Rule Declaration
		]"
	purpose: "[
		To capture the notions of a CSS Style Rule Declaration, which consists
		of a Property (key) and a Value (e.g. key-value pair).
		]"
	how: "[
		By providing the basis for forming descendant classes representing potential
		instances of actual CSS style rules that can be applied to various HTML_ELEMENT
		objects.
		]"
	examples: "[
		┌─────────────────────────────────────────────────────────┬────────┬─────────────────────────────────────────────────────────────────────────────────────────────┐
		│Property (Key)											  │	   =   │						Value(s)															 │
		├─────────┬───┬───────────┬───┬───────────────────────────┼────────┼──────────────────────────────────────────────────────────────────────────────┬──────────────┤
		│first-id │	- │	second-id │	- │	third-id				  │	becomes│manifest-number / function / name-list / shorthand-list	uom | uom-list		  │	separator	 │
		├─────────┼───┼───────────┼───┼───────────────────────────┼────────┼──────────────────────────────────────────────────────────────────────────────┼──────────────┤
		│font						-	family						[ : ]	[ csv_list ... ]																[ ; ]
		│background					-	image						[ : ]	[ f ( x ) ... ]																	[ ; ]
		│filter														[ : ]	[ f ( x ) ... ]																	[ ; ]
		│list		-	style		-	image						[ : ]	[ f ( x ) ... ]																	[ ; ]			
		│background													[ : ]	[ shorthand_list ... ]															[ ; ]
		│border						-	style						[ : ]	[ shorthand_list ... ]															[ ; ]
		│border														[ : ]	[ shorthand_list ... ]															[ ; ]
		│list														[ : ]	[ shorthand_list ... ]															[ ; ]
		│margin														[ : ]	[ shorthand_list ... ]															[ ; ]
		│outline													[ : ]	[ shorthand_list ... ]															[ ; ]
		│padding		-											[ : ]	[ shorthand_list ... ]															[ ; ]
		│clear														[ : ]	both																			[ ; ]
		│text						-	align						[ : ]	center | right | left															[ ; ]
		│list		-	style		-	type						[ : ]	circle | square | ...															[ ; ]
		│border						-	collapse					[ : ]	collapse																		[ ; ]
		│position													[ : ]	fixed | relative																[ ; ]
		│visibility													[ : ]	hidden																			[ ; ]
		│height														[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│margin		- [ top | bottom | left | right ]				[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│max						-	height						[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│max						-	width						[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│min						-	height						[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│min						-	width						[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│padding	- [ top | bottom | left | right ]				[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│right														[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│top														[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│width														[ : ]	int	[ px | pc | cm | in | ... ]													[ ; ]
		│outline					-	width						[ : ]	int | [ thin | medium | thick | length | inherit ]	[ px | pc | cm | in | ... ]	[ ; ]
		│background					-	color						[ : ]	name | #hex | rgb ( n, n, n )													[ ; ]	
		│color														[ : ]	name | #hex | rgb ( n, n, n )													[ ; ]
		│outline					-	color						[ : ]	name | #hex | rgb ( n, n, n )													[ ; ]
		│border		- [ top | bottom | left | right ]	-	style	[ : ]	none | dotted | dashed | solid ...												[ ; ]
		│outline					-	style						[ : ]	none | dotted | dashed | solid ...												[ ; ]
		│display													[ : ]	none | inline | block															[ ; ]
		│text						-	decoration					[ : ]	none | underline																[ ; ]
		│font						-	style						[ : ]	normal | italic | oblique														[ ; ]
		│font						-	size						[ : ]	NOTE: Use <h1> ... <h6> | int | real	px | em									[ ; ]
		│opacity													[ : ]	real	uom																		[ ; ]
		│float														[ : ]	right | left																	[ ; ]
		└─────────┴───┴───────────┴───┴───────────────────────────┴────────┴──────────────────────────────────────────────────────────────────────────────┴──────────────┘
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CSS_DECLARATION

feature {NONE} -- Initialization

	make (a_objects: attached like creation_objects_anchor)
			-- Initialize Current with `a_data'.
		deferred
		end

feature -- Access

	name: STRING
			-- Declaration identifier name.
		deferred
		end

	property_value_pairs: ARRAY [TUPLE [property, value: STRING]]
			-- `property_value_pairs' for Current as a collection of key-value TUPLEs.
		attribute
			Result := <<>>
		end

feature -- Generators

	string: STRING
			-- Well-formed CSS Style Rule Declaration.
		deferred
		end

feature {NONE} -- Implementation: Access

	first_id,
	second_id,
	third_id: detachable STRING
			-- First, Second, and Third Identifier names for Current.

	becomes: CHARACTER = ':'
			-- Key:Value or Property:Value pair separator for Current.

	manifest_integer: INTEGER
			-- Integer value (if any) for Current.

	manifest_real: REAL
			-- Real value (if any) for Current.

	function: detachable ANY
			-- Function for Current. (example: color: rgb(255,0,0);)

	value_name: detachable STRING
			-- Optional `value_name' for Current.

	value_name_list: ARRAY [STRING]
			-- Names available to `value_name' as a list.
		attribute
			Result := <<>>
		end

	shorthand_list: ARRAY [CSS_DECLARATION]
			-- When Current can be a short-hand list, these items are the source of the list.
		attribute
			Result := <<>>
		end

	uom: detachable STRING
			-- When `manifest_integer' or `manifest_real' are in play for Current.

	separator: CHARACTER = ';'
			-- Character placed at the end of each Current.

feature {NONE} -- Implementation

	creation_objects_anchor: detachable TUPLE [detachable ANY]
			-- Type anchor for objects required for creation.
		deferred
		end

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
