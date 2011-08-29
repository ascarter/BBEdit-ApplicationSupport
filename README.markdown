BBEdit Application Support
==========================

BBEdit language modules, clippings, scripts and customizations.

I use BBEdit's Dropbox support. I maintain my customizations in this git repository. When I want to push my changes to my BBEdit install, I use the Rake installer to copy them.

The Rakefile will prefer Dropbox but will fall back to the local `~/Library/Application Support` if Dropbox is not found.

# Install

	git clone git@github.com:ascarter/BBEdit-ApplicationSupport.git
	cd BBEdit-ApplicationSupport
	rake install

The `rakefile` script will create empty directories for the components if they do not exist in the BBEdit support directory. It will also prompt you to decide if you want to override existing files or not.
