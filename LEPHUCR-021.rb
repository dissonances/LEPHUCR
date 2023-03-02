# Define the filenames for the input and output files
input_files = Dir.glob("1-plantar-cara/*.md")
bibliography_file = input_files.pop(&:last)

# Read the bibliography file and extract the footnote links
footnote_links = {}
File.readlines(bibliography_file).each do |line|
  if line.match(/^\[\^(.*)\]: (.*)$/)
    footnote_links[$1] = $2.strip
  end
end

# Replace the footnote links in the input files
# Iterate over the files to search and replace any references to footnotes
input_files.each do |filename|
  # Read in the file
  content = File.read(filename)

  # Replace any references to footnote_links
  content.gsub!(/\[\^(?<number>\d+)\]/) do |match|
    number = $~[:number]
    #require 'pry-byebug'; binding.pry
    if footnote_links.key?(number)
      "^(#{footnote_links[number]})"
    else
      match
    end
  end

  # Write out the updated file
  File.write(filename, content)
end
