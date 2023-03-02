# Description

There is an alternative syntax for creating footnotes in Markdown that doesn't rely on enumerating them with numbers. This syntax uses caret (^) symbols to mark the beginning of the footnote, and a corresponding caret symbol to mark the end of the footnote:

`Saber hacer^[The ability to do something well or efficiently.] is an important skill to have.`

This will create an unenumerated footnote at the bottom of the page, with the text "The ability to do something well or efficiently.".

Pandoc, which is a popular tool for converting between different markup languages, supports this syntax for footnotes in Markdown, and will convert it to the appropriate LaTeX code when you convert your document from Markdown to LaTeX.

Here's an example of how you would convert the Markdown code above to LaTeX using Pandoc:

`Saber hacer\footnote{The ability to do something well or efficiently.} is an important skill to have.`

When you run Pandoc to convert this Markdown document to LaTeX, the footnote will be converted to the appropriate LaTeX code, and will appear as an unenumerated footnote at the bottom of the page.

# Work

```ruby
# Read the bibliography file
bibliography = File.read("1-plantar-cara/bibliography.md")

# Get all the footnotes from the bibliography
footnotes = bibliography.scan(/\[\^(\d+)\]: (.+)/)

# Group the footnotes by their number
footnote_hash = Hash.new
footnotes.each do |footnote|
  number = footnote[0]
  text = footnote[1]
  footnote_hash[number] = text
end

# Iterate over each Markdown file in the 1-plantar-cara directory
Dir.glob("1-plantar-cara/*.md") do |file|
  # Read the contents of the Markdown file
  contents = File.read(file)

  # Find all the references to footnotes in the file
  references = contents.scan(/\[(\d+)\]/)

  # Iterate over each reference to a footnote in the file
  references.each do |reference|
    number = reference[0]
    footnote_text = footnote_hash[number]

    # Format the footnote text for inclusion in the Markdown file
    footnote_text = footnote_text.split(": ")[1]
    footnote_text = footnote_text.gsub(/\[(\d+)\]/, '')
    footnote_text = "(#{footnote_text})"

    # Replace the reference with the formatted footnote text
    contents = contents.gsub("[#{number}]", "[#{number}#{footnote_text}]")
  end

  # Find the References heading in the file and insert the footnotes
  contents = contents.gsub("# References", "# References\n\n")
  contents = contents.gsub("# References\n\n", "# References\n\n#{footnote_hash.values.join("\n\n")}\n\n")

  # Write the modified contents back to the file
  File.write(file, contents)
end

```
