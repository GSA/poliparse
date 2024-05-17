require 'fileutils'

# Function to read file, extract sentences with 'must' or 'should', and write to a new file
def extract_and_write_sentences(file_path, keywords)
  # Read the file content
  content = File.read(file_path)

  content.gsub!(/(?<![.?!])\n/, ' ')


  # Split the content into sentences using a regular expression
  sentences = content.split(/(?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s/)

  # Initialize a hash to store sentences by keyword
  sentences_by_keyword = {}

  # Populate the hash with empty arrays for each keyword
  keywords.each do |keyword|
    sentences_by_keyword[keyword] = []
  end

  # Filter sentences containing each keyword
  sentences.each do |sentence|
    keywords.each do |keyword|
      if sentence.downcase.include?(keyword)
        # mark keywords in bold
        formatted_sentence = sentence.gsub(/(#{keyword})/i, '**\1**')
        sentences_by_keyword[keyword] << formatted_sentence.strip
      end
    end
  end

  # Ensure the 'markdown' directory exists
  output_dir = 'markdown'
  FileUtils.mkdir_p(output_dir)

  # Determine the new file name with .md extension in the output_dir
  new_file_name = File.basename(file_path, ".*") + '-parsed.md'
  new_file_path = File.join(output_dir, new_file_name)

  # Open the new file for writing
  File.open(new_file_path, 'w') do |file|
    # Write sentences for each keyword
    keywords.each do |keyword|
      file.puts "## #{keyword.capitalize} sentences"
      file.puts ""
      sentences_by_keyword[keyword].each { |sentence| file.puts "* [ ] #{sentence}" }
      file.puts "\n" unless sentences_by_keyword[keyword].empty?
    end
  end

  puts "Output written to #{new_file_path}"
end

if ARGV.empty?
  puts "Please provide the path to the text file as an argument."
  exit
end

# Define the path to the text file
# file_path = 'text/m-23-22.txt'
# or
# Get the path to the text file from the first argument
file_path = ARGV[0]

# Define the keywords to look for
keywords = ['must', 'should', 'could', 'may']

# Call the function
extract_and_write_sentences(file_path, keywords)
