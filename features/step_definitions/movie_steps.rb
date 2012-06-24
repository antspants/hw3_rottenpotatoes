# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(director: movie[:director], title: movie['title'], rating: movie['rating'], release_date: movie['release_date'])
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.should =~ /.*(#{e1}).*(#{e2}).*/m
end

Then /^I should not see "(.*?)" before "(.*?)"$/ do |e1, e2|
  page.body.should_not =~ /.*(#{e1}).*(#{e2}).*/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(',')
  case uncheck
  when 'un' 
    ratings.each { |rating| step %Q|I uncheck "#{rating}"| }
  else 
    ratings.each { |rating| step %Q|I check "#{rating}"| }
  end

  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

=begin
When /^I check the 'PG' and 'R' checkboxes$/ do
  pending # express the regexp above with the code you wish you had
end
=end



Then /I should see the following films/ do |movies_table|
  movies_table.hashes.each do |movie|
    step %Q|I should see "#{movie[:title]}"| 
  end
end

Then /^I should not see the following films:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    step %Q|I should not see "#{movie[:title]}"| 
  end
end

When /^all ratings are unchecked$/ do
  ratings = Movie.all_ratings
  ratings.each { |rating| step %Q|I uncheck "#{rating}"| }
end

When /^all ratings are checked$/ do
  ratings = Movie.all_ratings
  ratings.each { |rating| step %Q|I check "#{rating}"| }
end

Then /^I should see all films$/ do
  page.should have_css("tbody#movielist tr", count: Movie.all.size) 
end

Then /^I should not see any films$/ do
  page.should_not have_css("tbody#movielist tr") ##, count: 0) 
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |film, director|
  page.should have_content(film)
  page.should have_content(film)
end

