tell application "BBEdit"
	-- Fetch Markdown syntax
	set markdownUrl to "http://daringfireball.net/projects/markdown/syntax.text"
	set cmd to "curl " & markdownUrl
	set markdownText to do shell script cmd
	set theWindow to make new text window with properties {contents:markdownText}
	set theDoc to document of theWindow
	set source language of theDoc to "Markdown"
	set name of theDoc to "Markdown Syntax"
	activate
	
	-- Preview in BBEdit
	--select theWindow
	--tell application "System Events"
	--	tell process "BBEdit"
	--		click menu item "Preview in BBEdit" of menu 1 of menu bar item "Markup" of menu bar 1
	--	end tell
	--end tell
end tell