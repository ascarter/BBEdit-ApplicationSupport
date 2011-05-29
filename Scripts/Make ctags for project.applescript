-- Build tags file for current BBEdit project

set _theFile to missing value

tell application "BBEdit"
	if (count of text windows) > 0 then
		-- Get the first text window. This will return any window that can
		-- contain a text document (standalone window, project window, etc.)
		-- and skips over Find windows, Scratchpads, and whatnot
		set _firstTextWindow to text window 1
		
		if (class of _firstTextWindow is project window) then
			set _projectDocument to project document of _firstTextWindow
			if (on disk of _projectDocument) then
				set _theProjectDir to file of _projectDocument
				
				tell application "Finder"
					set _theFile to container of _theProjectDir
				end tell
			else
				-- Shipping versions of BBEdit don't provide direct access
				-- to the Instaproject root, so fake it by asking for
				-- the first node from the project list
				set _theFile to item 1 of _projectDocument
			end if
		else if (class of _firstTextWindow is text window) then
			if (on disk of document of _firstTextWindow) then
				set _theFile to file of document of _firstTextWindow
			end if
		end if
	end if
end tell

if _theFile is equal to missing value then
	-- No base file found for reference
	-- Signal error by beep and end
	beep
else
	-- Run the maketags script
	set _thePath to POSIX path of _theFile
	set cmd to "cd " & _thePath & "; /usr/local/bin/bbedit --maketags"
	do shell script cmd
end if