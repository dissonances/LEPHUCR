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
input_files.each do |input_file|
  # Read the input file and split it into lines
  lines = File.readlines(input_file)

  # Find the index of the "# References" heading
  references_index = lines.find_index { |line| line.match(/^# References/) }

  if references_index
    # Split the file into the part before and after the references section
    pre_references = lines[0...references_index]
    post_references = lines[references_index..-1]

    # Replace any footnote links in the post-references section
    post_references.map! do |line|
      line.gsub(/\[\^([^\]]+)\]/) do
        footnote_number = $1
        footnote_content = footnote_links[footnote_number]

        # Format the footnote content and wrap it in parentheses
        "(#{footnote_content.sub(/^\[\d+\]\s+/, '')})"
      end
    end

    # Write the updated file contents to disk
    File.write(input_file, (pre_references + post_references).join(""))
  end
end
