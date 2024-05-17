Parsing .pdf policies into text for further analysis.

#### Example

Parse a .pdf in the `/documents` folder to a a .txt file in the `/text` folder using:

```bash
pdftotext documents/M-23-22-Delivering-a-Digital-First-Public-Experience.pdf text/m-23-23.txt
```

Parse the a .txt file into an .md file in the `/markdown` directory using:

```bash
ruby parse.rb text/m-23-22.txt
=> Output written to markdown/m-23-22-parsed.md
```

#### Dependencies

* `pdftotext`, which can be installed using `brew install poppler` on OSX.
* Ruby 3.0+
