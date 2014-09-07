note
	description : "ehtml application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
--			l_html_element: HTML_ELEMENT
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")
		end

end
