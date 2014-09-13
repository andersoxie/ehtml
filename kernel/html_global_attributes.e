note
	description: "[
		Abstract helper with HTML Global Attributes to apply.
		]"
	how: "[
		By providing access to setting values and forming (deriving) HTML5 attributes from
		the set values. Also, by providing appropriate class invariants to ensure proper
		formatting of various HTML5 attributes at run-time.


		Attribute		Description
		-----------		--------------------------------------------------
		accesskey		Specifies a shortcut key to activate/focus an element
		class			Specifies one or more classnames for an element (refers to a class in a style sheet)
		contenteditable	Specifies whether the content of an element is editable or not
		contextmenu		Specifies a context menu for an element. The context menu appears when a user right-clicks on the element
		data-*			Used to store custom data private to the page or application
		dir				Specifies the text direction for the content in an element
		]"
	Todos: "[
		draggable		Specifies whether an element is draggable or not (true/false)
		dropzone		Specifies whether the dragged data is copied, moved, or linked, when dropped
		hidden			Specifies that an element is not yet, or is no longer, relevant
		id				Specifies a unique id for an element
		lang			Specifies the language of the element's content
		spellcheck		Specifies whether the element is to have its spelling and grammar checked or not
		style			Specifies an inline CSS style for an element
		tabindex		Specifies the tabbing order of an element
		title			Specifies extra information about an element
		translate		Specifies whether the content of an element should be translated or not
		]"
	EIS: "name=global_attributes", "src=http://www.w3schools.com/tags/ref_standardattributes.asp", "protocol=URI"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTML_GLOBAL_ATTRIBUTES

feature -- Access

	attributes: STRING
			-- Values for all attributes of Current, except data-*.
		do
			Result := access_key_attribute
			Result.append_character (space_8)
			Result.append_string (class_attribute)
			Result.append_character (space_8)
			Result.append_string (content_editable_attribute)
			Result.append_character (space_8)
			Result.append_string (dir_attribute)
			Result.append_character (space_8)
			Result.append_string (draggable_attribute)
		end

	attributes_with_data (a_data_attribute_key: detachable STRING): STRING
			-- Values of all attributes of Current.
		do
			Result := attributes
			Result.append_character (space_8)
			if attached a_data_attribute_key as al_key then
				Result.append_string (data_attribute_for_key (al_key))
			end
		end

feature -- Access: Access Attribute

	access_key_attribute: STRING
			-- Well formed HTML "accesskey" global attribute.
		note
			purpose: "[
				The accesskey attribute specifies a shortcut key to activate/focus an element.
				]"
			how: "[
				By returning either an empty string, indicative of detached `access_key_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_accesskey.asp", "protocol=URI"
		do
			check attached access_key_attribute_value as al_value then
				Result := well_formed_html_attribute (access_key_identifier, al_value, is_double_quoted)
			end
		end

	access_key_attribute_value: detachable STRING
			-- HTML "access_key" global attribute value (optional). See `access_key_attribute' above and setter/reset below.

	access_key_identifier: STRING = "accesskey"
			-- Identifier constants for `access_key_attribute'.

feature -- Access: Class Attribute

	class_attribute: STRING
			-- Well formed HTML "class" global attribute.
		note
			purpose: "[
				The class attribute specifies one or more classnames for an element.
				
				The class attribute is mostly used to point to a class in a style sheet. However, it can also 
				be used by a JavaScript (via the HTML DOM) to make changes to HTML elements with a specified 
				class.
				]"
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				
				In HTML5, the class attribute can be used on any HTML element (it will validate on any HTML element. 
				However, it is not necessarily useful).
				
				In HTML 4.01, the class attribute cannot be used with: <base>, <head>, <html>, <meta>, <param>, 
					<script>, <style>, and <title>.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_class.asp", "protocol=URI"
			examples: "[
				Syntax: <element class="classname">
				]"
		do
			check attached class_attribute_value as al_value then
				Result := well_formed_html_attribute (class_identifier, al_value, is_double_quoted)
			end
		end

	class_attribute_value: detachable STRING
			-- HTML "class" global attribute value (optional). See `class_attribute' above and setter/reset below.

	class_identifier: STRING = "class"
			-- Identifier constants for `class_attribute'.

feature -- Access: Content Editable Attribute

	content_editable_attribute: STRING
			-- Well formed HTML "class" global attribute.
		note
			purpose: "[
				The contenteditable attribute specifies whether the content of an element is editable or not.
				
				Note: When the contenteditable attribute is not set on an element, the element will inherit it from its parent.
				]"
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_contenteditable.asp", "protocol=URI"
			examples: "[
				Syntax: <element contenteditable="true|false">
				
				Attribute Values
				====================
				Value	Description
				------- ------------------------------------------
				true	Specifies that the element is editable
				false	Specifies that the element is not editable
				]"
		local
			l_flag: STRING
		do
			l_flag := content_editable_attribute_value.out
			l_flag.to_lower
			Result := well_formed_html_attribute (content_editable_identifier, l_flag, is_double_quoted)
		end

	content_editable_attribute_value: BOOLEAN
			-- HTML "contenteditable" global attribute value ("false" by default). See `content_editable_attribute' above and setter/reset below.

	content_editable_identifier: STRING = "contenteditable"
			-- Identifier constants for `content_editable_attribute'.

feature -- Access: Data-* Attribute

	data_attribute_for_key (a_key: STRING): STRING
			-- Well formed HTML "data=*" global attribute.
		note
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value' or a 
				fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_data.asp", "protocol=URI"
			examples: "[
				Syntax: <element data-*="somevalue">
				
				Retrieve from this list by: Current.data_attributes ["animal-type-bird"] from: item alias "[]" (key: K): detachable G
				]"
		require
			has_key_value: data_attributes.has (a_key)
		do
			check has_value: attached {like data_attribute_value_anchor} data_attributes [a_key] as al_value then
				Result := well_formed_html_attribute (data_identifier + al_value.attribute_name, al_value.attribute_value, is_double_quoted)
			end
		end

	data_attributes: HASH_TABLE [TUPLE [STRING, STRING], STRING]
			-- Hash of data attributes, name and value (key-value pairs).
		note
			purpose: "[
				The data-* attributes is used to store custom data private to the page or application.
				The data-* attributes gives us the ability to embed custom data attributes on all HTML elements.
				
				The stored (custom) data can then be used in the page's JavaScript to create a more engaging user 
				experience (without any Ajax calls or server-side database queries).
				
				The data-* attributes consist of two parts:
				
				1. The attribute name should not contain any uppercase letters, and must be at least one character long
				after the prefix "data-"
				2. The attribute value can be any string
				
				Note: Custom attributes prefixed with "data-" will be completely ignored by the user agent [g].
				]"
			examples: "[
				Retrieve from this list by: Current.data_attributes ["animal-type-bird"] from: item alias "[]" (key: K): detachable G
			glossary: "[
				user agent: In computing, a user agent is software (a software agent) that is acting on behalf 
								of a user. For example, an email reader is a mail user agent, and in the Session 
								Initiation Protocol (SIP), the term user agent refers to both end points of a 
								communications session.
				]"
		attribute
			create Result.make (0)
		end

	data_identifier: STRING = "data-"
			-- Identifier constants for `data_attribute_for_key'.

feature -- Access: Direction Attribute

	dir_attribute: STRING
			-- Direction based on optional `dir_attribute_value'.
		do
			if attached dir_attribute_value as al_value then
				Result := dir_attribute_for_indicator (al_value)
			else
				Result := ""
			end
		end

	dir_attribute_value: detachable STRING
			-- HTML "dir" global attribute value (optional). See `dir_attribute_for_indicator' above and setter/reset below.

	dir_attribute_for_indicator (a_dir_indicator: STRING): STRING
			-- Direction attribute depending on `a_dir_indicator'.
		note
			EIS: "name=dir_attribute", "src=http://www.w3schools.com/tags/att_global_dir.asp", "protocol=URI"
		require
			valid_indicator: (<<left_to_right_identifier, right_to_left_identifier, auto_identifier>>).has (a_dir_indicator)
		do
			create Result.make_empty
			if a_dir_indicator.same_string (left_to_right_identifier) then
				Result := dir_left_to_right_attribute
			elseif a_dir_indicator.same_string (right_to_left_identifier) then
				Result := dir_right_to_left_attribute
			elseif a_dir_indicator.same_string (auto_identifier) then
				Result := dir_auto_attribute
			end
		ensure
			has_dir_equal: Result.has_substring ("dir=")
			valid_indicator: Result.has_substring (left_to_right_identifier) or
								Result.has_substring (right_to_left_identifier) or
								Result.has_substring (auto_identifier)
			is_quoted: Result.has ('"') and Result.occurrences ('"') = 2
		end

	dir_left_to_right_attribute: STRING
			-- Direction attribute for left-to-right.
		note
			EIS: "name=dir_attribute", "src=http://www.w3schools.com/tags/att_global_dir.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dir_identifier, left_to_right_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dir=%"ltr%"")
		end

	dir_right_to_left_attribute: STRING
			-- Direction attribute for right-to-left.
		note
			EIS: "name=dir_attribute", "src=http://www.w3schools.com/tags/att_global_dir.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dir_identifier, right_to_left_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dir=%"rtl%"")
		end

	dir_auto_attribute: STRING
			-- Direction attribute for auto.
		note
			EIS: "name=dir_attribute", "src=http://www.w3schools.com/tags/att_global_dir.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dir_identifier, auto_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dir=%"auto%"")
		end

	dir_identifier: STRING = "dir"
			-- Identifier constants for `dir_*'.

	left_to_right_identifier: STRING = "ltr"
			-- Identifer constants for left-to-right.

	right_to_left_identifier: STRING = "rtl"
			-- Identifer constants for right-to-left.

	auto_identifier: STRING = "auto"
			-- Identifer constants for auto.

feature -- Access: Draggable Attribute

	draggable_attribute: STRING
			-- Well formed HTML "draggable" global attribute.
		note
			purpose: "[
				]"
			how: "[
				By returning either an empty string, indicative of detached `class_attribute_value'
				or a fully formed class attribute in accordance with HTML5 specifications.
				]"
			EIS: "name=class attribute", "src=http://www.w3schools.com/tags/att_global_draggable.asp", "protocol=URI"
			examples: "[
				Syntax: <element draggable="true|false">
				
				Attribute Values
				====================
				Value	Description
				------- ------------------------------------------
				true	Specifies that the element is editable
				false	Specifies that the element is not editable
				]"
		local
			l_flag: STRING
		do
			l_flag := draggable_attribute_value.out
			l_flag.to_lower
			Result := well_formed_html_attribute (draggable_identifier, l_flag, is_double_quoted)
		end

	draggable_attribute_value: BOOLEAN
			-- HTML "draggable" global attribute value ("false" by default). See `draggable_attribute' above and setter/reset below.

	draggable_identifier: STRING = "draggable"
			-- Identifier constants for `draggable_attribute'.

feature -- Access: Dropzone Attribute

	dropzone_attribute: STRING
			-- ??
		do
			if attached dropzone_attribute_value as al_value then
				Result := dropzone_attribute_for_indicator (al_value)
			else
				Result := ""
			end
		end

	dropzone_attribute_value: detachable STRING
			-- HTML "dropzone" global attribute value (optional). See `dropzone_attribute_for_indicator' above and setter/reset below.

	dropzone_attribute_for_indicator (a_dropzone_indicator: STRING): STRING
			-- Direction attribute depending on `a_dropzone_indicator'.
		note
			EIS: "name=dir_attribute", "src=http://www.w3schools.com/tags/att_global_dropzone.asp", "protocol=URI"
		require
			valid_indicator: (<<copy_identifier, move_identifier, link_identifier>>).has (a_dropzone_indicator)
		do
			create Result.make_empty
			if a_dropzone_indicator.same_string (copy_identifier) then
				Result := dropzone_copy_attribute
			elseif a_dropzone_indicator.same_string (move_identifier) then
				Result := dropzone_move_attribute
			elseif a_dropzone_indicator.same_string (link_identifier) then
				Result := dropzone_link_attribute
			end
		ensure
			has_dropzone_equal: Result.has_substring ("dropzone=")
			valid_indicator: Result.has_substring (copy_identifier) or
								Result.has_substring (move_identifier) or
								Result.has_substring (link_identifier)
			is_quoted: Result.has ('"') and Result.occurrences ('"') = 2
		end

	dropzone_copy_attribute: STRING
			-- dropzone attribute for copy_identifier.
		note
			EIS: "name=dropzone_attribute", "src=http://www.w3schools.com/tags/att_global_dropzone.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dropzone_identifier, copy_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dropzone=%"copy%"")
		end

	dropzone_move_attribute: STRING
			-- dropzone attribute for right-to-left.
		note
			EIS: "name=dropzone_attribute", "src=http://www.w3schools.com/tags/att_global_dropzone.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dropzone_identifier, move_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dropzone=%"move%"")
		end

	dropzone_link_attribute: STRING
			-- dropzone attribute for link.
		note
			EIS: "name=dropzone_attribute", "src=http://www.w3schools.com/tags/att_global_dropzone.asp", "protocol=URI"
		do
			Result := well_formed_html_attribute (dropzone_identifier, link_identifier, is_double_quoted)
		ensure
			valid_result: Result.same_string ("dropzone=%"link%"")
		end

	dropzone_identifier: STRING = "dropzone"
			-- Identifier constants for `dropzone'.

	copy_identifier: STRING = "copy"
			-- Identifer constants for copy.

	move_identifier: STRING = "move"
			-- Identifer constants for move.

	link_identifier: STRING = "link"
			-- Identifer constants for link.

feature -- Status Report: Contract Support

	frozen is_valid_attribute_value (a_value: STRING): BOOLEAN
			-- Is `a_value' a valid attribute value?
		note
			how: "[
				`a_value' must start with A-Z|a-z and the remaining characters must conform to
					A-Z|a-z|0-9|"_"|"-" and cannot be empty.
				]"
		do
			Result := a_value.count > 0
			Result := Result and ({HTML_CONSTANTS}.uppercase_a_to_z.has (a_value [1]) or
									{HTML_CONSTANTS}.lowercase_a_to_z.has (a_value [1]))
			Result := Result and across a_value as ic_content all
										{HTML_CONSTANTS}.uppercase_a_to_z.has (ic_content.item) or
										{HTML_CONSTANTS}.lowercase_a_to_z.has (ic_content.item) or
										{HTML_CONSTANTS}.numeric_digits.has (ic_content.item) or
										{HTML_CONSTANTS}.special_characters.has (ic_content.item)
									end
		end

feature -- Settings: Access Attribute

	set_access_key_attribute_value (a_access_key_attribute_value: attached like access_key_attribute_value)
			-- Sets `access_key_attribute_value' with `a_access_key_attribute_value'.
		do
			access_key_attribute_value := a_access_key_attribute_value
		ensure
			access_key_attribute_value_set: access_key_attribute_value = a_access_key_attribute_value
		end

	reset_access_key_attribute_value
			-- Resets `access_key_attribute_value' to Void.
		do
			access_key_attribute_value := Void
		ensure
			detached: not attached access_key_attribute_value
		end

feature -- Settings: Class Attribute

	set_class_attribute_value (a_class_attribute_value: attached like class_attribute_value)
			-- Sets `class_attribute_value' with `a_class_attribute_value'.
		do
			class_attribute_value := a_class_attribute_value
		ensure
			class_attribute_value_set: class_attribute_value = a_class_attribute_value
		end

	reset_class_attribute_value
			-- Resets `class_attribute_value' to Void.
		do
			class_attribute_value := Void
		ensure
			detached: not attached class_attribute_value
		end

feature -- Settings: Content Editable Attribute

	set_content_editable_attribute_value (a_content_editable_attribute_value: attached like content_editable_attribute_value)
			-- Sets `content_editable_attribute_value' with `a_content_editable_attribute_value'.
		do
			content_editable_attribute_value := a_content_editable_attribute_value
		ensure
			content_editable_attribute_value_set: content_editable_attribute_value = a_content_editable_attribute_value
		end

	reset_content_editable_value
			-- Resets `content_editable_attribute_value' to Void.
		do
			content_editable_attribute_value := False
		ensure
			set: not content_editable_attribute_value
		end

feature -- Settings: Data Attribute

	set_data_attribute (a_value: attached like data_attribute_value_anchor; a_key: STRING)
			-- Set `a_value' and `a_key' into `data_attributes'.
		do
			data_attributes.force (a_value, a_key)
		ensure
			has_entry: attached {attached like data_attribute_value_anchor} data_attributes.at (a_key) as al_value and then
						al_value.attribute_name.same_string (a_value.attribute_name) and then
						al_value.attribute_value.same_string (a_value.attribute_value)
		end

	data_attribute_value_anchor: detachable TUPLE [attribute_name, attribute_value: STRING]

feature -- Settings: Direction Attribute

	set_dir_attribute_value (a_dir_attribute_value: attached like dir_attribute_value)
			-- Sets `dir_attribute_value' with `a_dir_attribute_value'.
		do
			dir_attribute_value := a_dir_attribute_value
		ensure
			dir_attribute_value_set: dir_attribute_value = a_dir_attribute_value
		end

	set_dir_left_to_right
			-- Set `dir_attribute_value' to `left_to_right_identifier'.
		do
			dir_attribute_value := left_to_right_identifier
		ensure
			set: attached dir_attribute_value as al_value and then al_value.same_string (left_to_right_identifier)
		end

	set_dir_right_to_left
			-- Set `dir_attribute_value' to `right_to_left_identifier'.
		do
			dir_attribute_value := right_to_left_identifier
		ensure
			set: attached dir_attribute_value as al_value and then al_value.same_string (right_to_left_identifier)
		end

	set_dir_auto
			-- Set `dir_attribute_value' to `auto_identifier'.
		do
			dir_attribute_value := auto_identifier
		ensure
			set: attached dir_attribute_value as al_value and then al_value.same_string (auto_identifier)
		end

	reset_dir_attribute_value
			-- Resets `dir_attribute_value' to Void.
		do
			dir_attribute_value := Void
		ensure
			detached: not attached dir_attribute_value
		end

feature -- Settings: Draggable Attribute

	set_draggable_attribute_value (a_draggable_attribute_value: attached like draggable_attribute_value)
			-- Sets `draggable_attribute_value' with `a_draggable_attribute_value'.
		do
			draggable_attribute_value := a_draggable_attribute_value
		ensure
			draggable_attribute_value_set: draggable_attribute_value = a_draggable_attribute_value
		end

	reset_draggable_value
			-- Resets `draggable_attribute_value' to Void.
		do
			draggable_attribute_value := False
		ensure
			set: not draggable_attribute_value
		end

feature -- Settings: Dropzone Attribute

	set_dropzone_attribute_value (a_dropzone_attribute_value: attached like dropzone_attribute_value)
			-- Sets `dropzone_attribute_value' with `a_dropzone_attribute_value'.
		do
			dropzone_attribute_value := a_dropzone_attribute_value
		ensure
			dropzone_attribute_value_set: dropzone_attribute_value = a_dropzone_attribute_value
		end

	set_dropzone_copy
			-- Set `dropzone_attribute_value' to `copy_identifier'.
		do
			dropzone_attribute_value := copy_identifier
		ensure
			set: attached dropzone_attribute_value as al_value and then al_value.same_string (copy_identifier)
		end

	set_dropzone_move
			-- Set `dropzone_attribute_value' to `move_identifier'.
		do
			dropzone_attribute_value := move_identifier
		ensure
			set: attached dropzone_attribute_value as al_value and then al_value.same_string (move_identifier)
		end

	set_dropzone_link
			-- Set `dropzone_attribute_value' to `link_identifier'.
		do
			dropzone_attribute_value := link_identifier
		ensure
			set: attached dropzone_attribute_value as al_value and then al_value.same_string (link_identifier)
		end

	reset_dropzone_attribute_value
			-- Resets `dir_attribute_value' to Void.
		do
			dropzone_attribute_value := Void
		ensure
			detached: not attached dropzone_attribute_value
		end

feature {NONE} -- Implementation: Basic Operations

	well_formed_html_attribute (a_name, a_value: STRING; a_is_quoted: BOOLEAN): STRING
			-- Create well-formed attribute with `a_name', equal ("=") to `a_value', with possible double quotes.
		require
			has_name: not a_name.is_empty
			has_value: not a_value.is_empty
		do
			Result := a_name.twin
			Result.append_character ('=')
			if a_is_quoted then
				Result.append_character ('"')
			end
			Result.append_string (a_value)
			if a_is_quoted then
				Result.append_character ('"')
			end
		ensure
			has_name_equal: Result.has_substring (a_name + "=")
			has_value: Result.has_substring (a_value)
			is_valid_quotations: a_is_quoted implies Result.has_substring ("%"" + a_value + "%"")
			has_equality_symbol: Result.has ('=')
		end

feature {NONE} -- Implementation: Constants

	space_8: CHARACTER_8
			-- Space character constant for Current.
		once
			Result := {HTML_CONSTANTS}.space_8
		end

	frozen is_double_quoted: BOOLEAN
			-- Named BOOLEAN constant indicative of some item wrapped in double-quotes.
		once
			Result := {HTML_CONSTANTS}.is_double_quoted
		end

invariant
	valid_class_attribute_value: attached class_attribute_value as al_value implies is_valid_attribute_value (al_value)
	valid_access_key_attribute_value: attached access_key_attribute_value as al_value implies is_valid_attribute_value (al_value)
	valid_data_values: data_attributes.count > 0 implies
						across data_attributes as ic_data all
							attached {like data_attribute_value_anchor} ic_data.item as al_data and then
								is_valid_attribute_value (al_data.attribute_value)
						end

end
