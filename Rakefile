require 'rake'
require 'erb'
require 'fileutils'

task :default => [ :install ]

desc "Install BBEdit support files to Application Support/BBEdit"
task :install do
  replace_all = false
  source_root = File.expand_path(File.join(__FILE__, '..'))
  source_dirs = [ 'Clippings', 'Color Schemes', 'Language Modules', 'Scripts' ]
  home_dir = File.expand_path(ENV['HOME'])
  
  # Find application support directory
  appsupport_root = File.join(home_dir, 'Dropbox', 'Application Support', 'BBEdit')
  if not File.exist?(appsupport_root)
    appsupport_root = File.join(home_dir, 'Library', 'Application Support', 'BBEdit')
    if not File.exist?(appsupport_root)
	  raise IOError.new('No BBEdit directory found in ~/Dropbox/Application Support or ~/Library/Application Support')
    end
  end
  
  puts "Installing to #{appsupport_root}"
  
  # Install files
  source_dirs.each do |d|
  	source_dir = File.join(source_root, d)
  	target_dir = File.join(appsupport_root, d)
  	
  	# Create the target dir if it doesn't exist
  	Dir.mkdir(target_dir) unless File.directory?(target_dir)
  	
  	# Get entry in source
  	Dir.glob(File.join(source_dir, '*')).each do |f|
  	  filename = File.basename(f)
  	  target = File.join(target_dir, filename)  	  
  	  if File.exist?(target)
  	  	if File.identical?(f, target)
  	  	  puts "Identical #{d}/#{filename}"
  	  	else
  	  	  if replace_all
  	  	    copy(f, target)
  	  	  else
  	  	    print "Replace existing file #{d}/#{filename}? [ynaq] "
  	  	    case $stdin.gets.chomp
  	  	    when 'a'
  	  	      replace_all = true
	  	  	  copy(f, target)
  	  	    when 'y'
	  	  	  copy(f, target)
  	  	    when 'q'
  	  	      puts "Abort"
  	  	      exit
  	  	    else
  	  	      puts "Skipping #{d}/#{filename}"
  	  	    end
  	  	  end
  	  	end
  	  else
  	  	copy(f, target)
  	  end
  	end
  end
  
  puts "Done."
end

def copy(source, target)
  dirname = File.dirname(source).split('/').last
  filename = File.basename(source)
  puts "Copy #{dirname}/#{filename}"
  FileUtils.cp_r(source, target)
end
