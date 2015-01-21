note
	title: "Root Notion of an HTML Element."
	description: "[
		Abstraction of an HTML Element.
		]"
	basics: "[
		An HTML element is something like <body>, <form>, <b>, <p>, and so on. Therefore,
		this class is designed to capture features that are fundamental to all HTML
		elements, specifically HTML-5.

		`tag' is HTML-5 element tag (e.g. "body" for <body>). Set as constant in descendent.

		`append_html' appends some given "HTML_string" with <tag> and </tag> enclosure.

		`text' content of Current (e.g. <title>This is the text content ...</title>).

		`content' as a STRING of the `contents' of Current appended to the end of a parent STRING.
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTML_ELEMENT

inherit
	HTML_ELEMENT_HELPER

feature {NONE} -- Initialization

	make_with_id (a_id: STRING)
			-- Initialize Current with optional ID attribute.
		do
			add_attribute (["id", a_id, True])
		end

feature -- Access

	tag: STRING
			-- HTML <tag> for Current.
		deferred
		end

	append_html (a_parent: STRING)
			-- Append HTML of Current to `a_parent' HTML.
		note
			how: "[
				By taking the `a_parent' HTML and appending first the <start>
				tag with "attributes" (manual and otherwise) and then passing
				that string downward to other subordinate contents. Finally, the
				<end> tag of Current is appended and the resulting `a_parent'
				STRING is passed back up to the Client caller.
				]"
		do
			a_parent.append_string (start_tag (tag, manual_attributes, global_attributes, not {HTML_CONSTANTS}.is_self_ending, True))
			content (a_parent)
			a_parent.append_string (end_tag (tag))
		end

	text: STRING
			-- Text content of Current.
		note
			purpose: "[
				To provide `text' content for Current as-needed, otherwise this
				feature returns an empty string by default, which (when appended)
				yields no appreciable change in the content of Current in the
				`append_html' stream (see above).
				]"
		attribute
			create Result.make_empty
		end

	content (a_parent: STRING)
			-- HTML representation of the content of Current.
		note
			how: "[
				By appending the HTML contents of Current to `a_parent' by passing
				`a_parent' into each `contents' item.
				]"
			example: "[
				<html><body>`content' <-- which is then ready to have </body> appended.
				]"
		do
			across contents as ic_contents loop ic_contents.item.append_html (a_parent) end
		end

	contents: ARRAYED_LIST [HTML_ELEMENT]
			-- HTML_ELEMENT items subordinate to Current.
		note
			example: "[
				Current might have <body><div> ... </div><div> ... </div></body> and be subordinate
				to <html>.
				]"
		attribute
			create Result.make (0)
		end

	global_attributes: detachable HTML_GLOBAL_ATTRIBUTES
			-- Attributes that are found in every HTML-5 <tag> element.

	manual_attributes: detachable STRING
			-- The `attributes' of Current representated as STRING.
		do
			if attributes.count > 0 then
				Result := " "
				across attributes as ic_attributes loop
					Result.append_string (ic_attributes.item.key)
					Result.append_character ('=')
					if ic_attributes.item.is_quoted then
						Result.append_character ('"')
					end
					Result.append_string (ic_attributes.item.value)
					if ic_attributes.item.is_quoted then
						Result.append_character ('"')
					end
					Result.append_character (' ')
				end
				Result.remove_tail (1)
			end
		ensure
			good_count: attached Result implies Result.occurrences ('=') = attributes.count -- always count on an equal sign for each attribute.
			good_keys: attached Result implies across attributes as ic_attributes all Result.has_substring (ic_attributes.item.key) end
			good_values: attached Result implies across attributes as ic_attributes all Result.has_substring (ic_attributes.item.value) end
		end

	attributes: ARRAYED_LIST [attached like attribute_anchor]
			-- Attributes of Current held as `key'/`value' pairs in either a quoted or non-quoted format.
		note
			description: "[
				A list of key-value pair attributes (quote-formatted or not), where Current defaults to
				having no attributes at all.
				]"
		attribute
			create Result.make (0)
		end

feature -- Settings

	add_content_item (a_item: HTML_ELEMENT)
			-- Add `a_item' to the `contents' of Current.
		do
			contents.force (a_item)
		ensure
			added: contents.has (a_item)
		end

	add_attribute (a_item: attached like attribute_anchor)
			-- Add `a_item' attribute to `attributes'.
		do
			attributes.force (a_item)
		ensure
			added: attributes.has (a_item)
		end

	set_text (a_text: like text)
			-- Set `text' with `a_text'.
		do
			text := a_text.twin
		ensure
			text_set: text ~ a_text
		end

feature {NONE} -- Implementation: Constants

	attribute_anchor: detachable TUPLE [key, value: STRING; is_quoted: BOOLEAN]
			-- Type anchor for attribute items.

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
