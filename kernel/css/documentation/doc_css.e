note
	description: "[
		Documentating for CSS Cluster
		]"
	purpose: "[
		To facilitate your learning of the CSS cluster.
		]"
	how: "[
		By presenting you with the basic structure of a CSS Style Rule in BNF-E followed by
		a list of the most used CSS style rules and then a discussion of how the CSS cluster
		of classes is constructed, where to start, and what classes you will most likely use.
		]"
	BNFE: "[
		Css_style_rule ::=
			{Selector}+ "{" {Declaration}+ "}" [{Comment}*]
		
		Selector (4) ::=
			Element_selector (1) | Id_selector (2) | Class_selector (3) 
			
		(1) The element selector selects elements based on the element name. You can select all <p> elements 
				on a page like this: (all <p> elements will be center-aligned, with a red text color)
				
				┌───────────────────────────────────────────┐
				│	p { text-align: center; color: red; }	│
				└───────────────────────────────────────────┘
				
		(2) The id selector uses the id attribute of an HTML tag to find the specific element. An id 
				should be unique within a page, so you should use the id selector when you want to find a 
				single, unique element. To find an element with a specific id, write a hash character, 
				followed by the id of the element. The style rule below will be applied to the HTML element 
				with id="para1":
				
				┌───────────────────────────────────────────────┐
				│	#para1 { text-align: center; color: red; }	│
				└───────────────────────────────────────────────┘
				
		(3) The class selector finds elements with the specific class. The class selector uses the HTML 
				class attribute. To find elements with a specific class, write a period character, followed 
				by the name of the class: In the example below, all HTML elements with class="center" will 
				be center-aligned:

				┌───────────────────────────────────────────────┐
				│	.center { text-align: center; color: red; }	│
				└───────────────────────────────────────────────┘

			You can also specify that only specific HTML elements should be affected by a class. In the example
				below, all p elements with class="center" will be center-aligned:

				┌───────────────────────────────────────────────────┐
				│	p.center { text-align: center; color: red; }	│
				└───────────────────────────────────────────────────┘

		(4) In style sheets there are often elements with the same style:

				┌───────────────────────────────────────────────────┐
				│	h1 { text-align: center; color: red; }			│
				│													│
				│	h2 { text-align: center; color: red; }			│
				│													│
				│	p { text-align: center; color: red; }			│
				└───────────────────────────────────────────────────┘

			To minimize the code, you can group selectors. To group selectors, separate each selector
			with a comma. In the example below we have grouped the selectors from the code above:

				┌───────────────────────────────────────────────────┐
				│	h1, h2, p { text-align: center; color: red; }	│
				└───────────────────────────────────────────────────┘
			
		Declaration ::=
			{Property ":" Value [";"]}+ (1)
			
		(1) Declarations consist of a set of one or more Property and Value parts separated by a colon
				and then each key-value pair is separated by semi-colons.
				
		Comment ::=
			"/*" [Standard_text] "*/" (1)
			
		(1) Example of a multi-line comment:
		
				┌───────────────────────────────────────────────────┐
				│	/* This is										│
				│	a multi-line									│
				│	comment */										│
				└───────────────────────────────────────────────────┘
		]"
	EIS: "name=css_syntax", "src=http://www.w3schools.com/css/css_syntax.asp", "protocol=URI", "tag=external"
	EIS: "name=css_selectors", "src=http://www.w3schools.com/css/css_selectors.asp", "protocol=URI", "tag=external"
	cheetsheet: "[
		Selected CSS Attributes
		
		This table highlights the most commonly used CSS attributes. Each of these attributes can be applied 
		to any container element in a page. The container can be a single element denoted by the ID attribute, 
		a member of a class, or all the elements in a page of a certain type.
		
		Attribute							Discussion
		================================	===================================================================================
		margin								Defines space between element border and parent (left, right, top, bottom variations)
		padding								Defines space between contents and border (with variants)
		border: size color style			Defines a border. Styles: none, dotted, dashed, solid, double, groove, ridge, inset, and outset.
		color								Foreground color: color name or hex value
		background-color					Background color: color name or hex value
		background-image: url(filename)		Sets image indicated by filename as background image
		background-repeat					Indicates how background will repeat: repeat, repeat-x, repeat-y, and no-repeat
		font-family							Font name: sans-serif, serif, monospace, cursive, and fantasy
		font-size							Font size (best specified in ems or percent)
		font-style							Set italics: none, italic, and oblique
		font-weight							Set boldness: lighter, normal, bold, and bolder (100-900)
		text-align							Alignment: left, right, center, and justify. Works on content, not a block
		text-decoration						Adds decoration to text: none, underline, overline, line-through, and blink
		display								Defines how element is displayed: none, block, and inline
		position							Describes positioning scheme: absolute and relative
		left, top, right, bottom			Indicates position of element (must set position absolute or relative first)
		float								Removes element from normal layout and floats it in a direction: left and right
		height, width						Specifies the height and width of an element. Important for floated elements.
		clear								Force this floated element to position: left, right, and both
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_CSS

note
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
