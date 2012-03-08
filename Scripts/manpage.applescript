-- manpage
--
-- View man page in BBEdit
--

-- man ls | col -b | bbedit --new-window
-- =============================================================================
-- Copyright (c) 2011 Andrew Carter
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
-- =============================================================================

on fetchManpage(theManpageName)
	set theScript to "man " & theManpageName & " | man2html"
	set thePage to do shell script theScript
	return thePage
end fetchManpage

on manpageDoc(the

tell application "BBEdit"
	set theResponse to display dialog "Manpage" default answer ""
	if button returned of theResponse is "OK" then
		set theManpageName to text returned of theResponse
		
		-- Get HTML version of man page
		set thePage to fetchManpage(theManpageName)
		
		-- Put in a text window
		set theWindow to make new text window with properties {contents:thePage}
		set theDoc to document of theWindow
		set name of theDoc to "man: " & theManpageName
		-- select line 1 of theDoc
		log insertion point of theDoc
		select insertion point before line 1 of theDoc
	end if
end tell