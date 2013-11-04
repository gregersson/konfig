tell application "Google Chrome"
	activate
	tell application "System Events"
		tell process "Google Chrome"
			keystroke "r" using {command down, shift down}
		end tell
	end tell
end tell
tell application "Emacs"
	activate
end tell
