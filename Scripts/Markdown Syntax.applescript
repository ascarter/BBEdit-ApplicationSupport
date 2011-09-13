-- Markdown Syntax
--
-- Displays Markdown Syntax guide
--
-- Installation:
-- 
-- Copy script to either location:
--   ~/Library/Application Support/BBEdit/Scripts
--   ~/Dropbox/Application Support/BBEdit/Scripts
--
-- To add a shortcut key:
--
--	 Window -> Palettes -> Scripts
--	 Select Markdown Syntax and click Set Key ...
--	 Enter a shortcut key combination (recommend Command + Option + M)
--
-- Credits:
--
-- Markdown Syntax source by John Gruber
-- http://daringfireball.net/projects/markdown/syntax.text
--
-- Author:  Andrew Carter <ascarter@gmail.com>
-- Version: 0.1
--
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

on fetchMarkdown()
	set markdownUrl to "http://daringfireball.net/projects/markdown/syntax.text"
	set cmd to "curl " & markdownUrl
	log ("Fetch markdown text => " & markdownUrl)
	set markdownText to do shell script cmd
	-- Clean up the submenu links to reference Daring Fireball
	tell application "BBEdit"
		set markdownText to replace "/projects/markdown/" using "http://daringfireball.net/projects/markdown/" searchingString markdownText
	end tell
	return markdownText
end fetchMarkdown

on findWindowByName(theName)
	tell application "BBEdit"
		repeat with x from 1 to the count of windows
			set _window to window x
			if name of _window is equal to theName then
				log ("Found window " & theName)
				return _window
			end if
		end repeat
		log ("Did not find " & theName)
		return missing value
	end tell
end findWindowByName

on markdownDoc(theTitle)
	tell application "BBEdit"
		set markdownText to fetchMarkdown() of me
		set _window to make new text window with properties {contents:markdownText, visible:false}
		set _doc to document of _window
		set source language of _doc to "Markdown"
		set name of _doc to theTitle
		set bounds of _window to {0, 0, 1, 1}
		return _window
	end tell
end markdownDoc

on previewMarkdown(sourceWindow)
	tell application "BBEdit"
		activate
		set collapsed of sourceWindow to false
		select sourceWindow
		log ("Use Preview in BBEdit for markdown")
		tell application "System Events"
			tell process "BBEdit"
				click menu item "Preview in BBEdit" of menu 1 of menu bar item "Markup" of menu bar 1
			end tell
		end tell
	end tell
end previewMarkdown

set theWindowTitle to "Markdown Syntax"
set theDoc to missing value
set theWindow to missing value
set thePreviewWindow to missing value

tell application "BBEdit"
	-- Is the preview window already available?
	set thePreviewWindow to findWindowByName("Preview: " & theWindowTitle) of me
	
	if thePreviewWindow is equal to missing value then
		-- Is there already a window with Markdown Syntax?
		set theWindow to findWindowByName(theWindowTitle) of me
		if theWindow is equal to missing value then
			set theWindow to markdownDoc(theWindowTitle) of me
			set theDoc to document of theWindow
		else
			set theDoc to the document of theWindow
		end if
		
		if theWindow is equal to missing value then
			-- Abort
			log ("No markdown syntax window")
			beep
			return
		end if
		
		-- Preview in BBEdit
		previewMarkdown(theWindow) of me
	end if
	
	-- Focus on the preview
	set thePreviewWindow to findWindowByName("Preview: " & theWindowTitle) of me
	if thePreviewWindow is not equal to missing value then
		select thePreviewWindow
	end if
	
	if theWindow is not equal to missing value then
		-- Minimize syntax window
		log ("Minimize the syntax window")
		-- set collapsed of theWindow to true
	end if
end tell