#### Requirements
#
#* The program must take a researcher's name from the user.  You decide how this should be done.  Is it a command line argument?  Is it a prompt?
#* The program must use HTTParty (or a similar gem) to connect to Google Scholar.
#* The program must use Nokogiri (or a similar gem) to traverse the HTML document's components.
#* At least three classes should be defined in your code.
#* The results of a search should be encapsulated in a single object (this object may, of course, wrap other objects as instance variables).
#
### Normal Mode
#
#The steps of the project will look something like this:
#
#* Fork this repository and clone it to your local machine.
#* Run the code.  You'll have to do something with gems and bundler before it will work.
#* Interpret what you think the code is trying to do.  It's not doing it correctly, but it does have a clear intent.
#  * Write tests to capture this intent.
#  * Modify the code to make the tests pass.
#  * Refactor the code to have an object-oriented structure.  Ensure that the tests still pass along the way (otherwise, it wouldn't be refactoring).
#  * Once your refactor is complete, begin writing code test-first.  Write a test to capture one of the new requirements below, make sure the test fails, then write code to make the test pass.  Refactor as needed.
#
#    In the simplest case, your program should:
#
#      * Take a researcher's name from the user
#      * Output a bibliography (via `puts` or similar) of the first 10 results in IEEE citation format (the format typically used in Computer Science).
#
#      Note that this citation format has MANY subrequirements, so test them one at a time.
#
#      The link to the IEEE citation formats is given below.  Consider the results to all be "Conference Technical Articles."
#
#
#
require 'httparty'
require 'nokogiri'
require './article.rb'

# Get the results page for Carlo Tomasi
page = Nokogiri::HTML(HTTParty.get("http://scholar.google.com/scholar?q=array+tomasi&hl=en&as_sdt=0,34").body)

# Get an array of links to titles
article_title_links = page.css(".gs_rt a")

# Pull out all the titles
titles = article_title_links.map {|l| l.children[0].to_s}

# Find all the publication years
years = page.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)}

# Write out all the publications in the form "2013 - Paper's Awesome Title"
titles.each_with_index do |t, i|
  puts "#{years[i]} - #{t}"
end


#puts"What is their first name"
#user_input1 = gets.chomp
#puts"What is their last name"
#user_input2 = gets.chomp

#get user input as string, splt at " "