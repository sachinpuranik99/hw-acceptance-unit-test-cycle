Given (/^the following movies exist:$/) do |table|
  table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then (/^the director of "([^"]*)" should be "([^"]*)"$/) do |movie_title, director_name|
  movie=Movie.find_by_title(movie_title)
  expect(movie.director).to eq director_name
end

Then (/I should see "(.*)" before "(.*)"/) do |movie_title1, movie_title2|
  body=page.body
  loc1=body.index(movie_title1)
  loc2=body.index(movie_title2)
  if loc1==nil || loc2==nil
    fail"One of the search parameters not found"
  else
    expect(loc1<loc2).to eq true
  end
end

When (/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end

Then (/I should see all the movies/) do
  movies = Movie.all
  movies.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end