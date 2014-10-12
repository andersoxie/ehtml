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
