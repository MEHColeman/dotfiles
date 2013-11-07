#!/usr/bin/env ruby
require 'fileutils'
SKIP_PATTERNS=[/^\./, /^bin$/, /^lib$/, /^util$/, /^README.md$/, /^BASH_PROFILE_NOTES.txt$/]
install_from_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))

def op_is_ok?(filename, home_filename)
  !File.exists?(home_filename) &&
    !skip?(filename)
end

def skip?(filename)
  SKIP_PATTERNS.map {|pattern| filename.match pattern}.compact.any?
end

home = ENV['HOME']
puts "install_from_dir = #{install_from_dir}"
puts "home = #{home}"
Dir.new(install_from_dir).each do |filename|
 home_filename =  File.join(home, ".#{filename}")
 dotfile_filename = File.join(install_from_dir, filename)

 if op_is_ok?(filename, home_filename)
  puts "will remove: home_filename = #{home_filename}"
  puts "dotfile_filename = #{dotfile_filename}"
  puts "will link #{dotfile_filename} to #{home_filename}"
  #FileUtils.remove_entry home_filename, true
  #FileUtils.ln_sf(dotfile_filename,home_filename)
 end
end
