#!/usr/bin/env ruby

# Create a new BBEdit package

# BBEdit now supports installing “packages” of items to extend its functionality.
# A package is simply a pre-defined group of the sort of items you can individually
# place into BBEdit’s application support folder (and subfolders) to extend BBEdit;
# however, the package format makes it easier to handle and install sets of related
# items.
#
# Each package is a folder whose name must ends in “.bbpackage”, and the items
# within this folder must conform exactly to the following requirements.
#
# The package folder must contain the following item:
#   * Contents [folder]
#
# The “Contents” folder may contain these two items (which are currently not
# required, and are reserved for future use):
#   * Resources [folder]
#   * Info.plist [file]
#
# The “Contents” folder may also contain any or all of the following subfolders:
#   * Clippings
#   * Language Modules
#   * Scripts
#   * Text Filters
#
# The items contained within each subfolder will behave as though they were
# present within the subfolder of the same name inside BBEdit’s application
# support folder. (These subfolders are all optional, though obviously a package
# which contains none of them will be of no benefit.)
#
# In order to use a populated package, you should place it within the “Packages”
# subfolder of BBEdit’s application support folder
# (~/Library/Application Support/BBEdit/Packages/).

require 'fileutils'

# Find application support directory
def find_appsupport_root
  home_dir = File.expand_path(ENV['HOME'])
  root = File.join(home_dir, 'Dropbox', 'Application Support', 'BBEdit')
  if not File.exist?(root)
    root = File.join(home_dir, 'Library', 'Application Support', 'BBEdit')
    if not File.exist?(root)
      raise IOError.new('No BBEdit directory found in ~/Dropbox/Application Support or ~/Library/Application Support')
    end
  end
  return root
end

package_name = ARGV[0] == nil ? "Untitled Package.bbpackage" : "#{ARGV[0]}.bbpackage"
appsupport_root = find_appsupport_root
packages_root = File.join(appsupport_root, "Packages")
target_root = File.join(packages_root, package_name)

# Create Packages directory
Dir.mkdir(packages_root) unless File.directory?(packages_root)

# Make sure package doesn't already exist
if File.directory?(target_root)
  raise IOError.new("Package already exists")
end

# Create the package
package_dirs = [
  'Resources', 'Clippings', 'Language Modules', 'Scripts', 'Text Filters'
]

Dir.mkdir(target_root)
Dir.mkdir(File.join(target_root, "Contents"))
File.new(File.join(target_root, "Contents", "Info.plist"), File::CREAT)
package_dirs.each { |d| Dir.mkdir(File.join(target_root, "Contents", d)) }

puts "Package #{package_name} created"




