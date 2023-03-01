There is an alternative syntax for creating footnotes in Markdown that doesn't rely on enumerating them with numbers. This syntax uses caret (^) symbols to mark the beginning of the footnote, and a corresponding caret symbol to mark the end of the footnote:

`Saber hacer^[The ability to do something well or efficiently.] is an important skill to have.`

This will create an unenumerated footnote at the bottom of the page, with the text "The ability to do something well or efficiently.".

Pandoc, which is a popular tool for converting between different markup languages, supports this syntax for footnotes in Markdown, and will convert it to the appropriate LaTeX code when you convert your document from Markdown to LaTeX.

Here's an example of how you would convert the Markdown code above to LaTeX using Pandoc:

`Saber hacer\footnote{The ability to do something well or efficiently.} is an important skill to have.`

When you run Pandoc to convert this Markdown document to LaTeX, the footnote will be converted to the appropriate LaTeX code, and will appear as an unenumerated footnote at the bottom of the page.