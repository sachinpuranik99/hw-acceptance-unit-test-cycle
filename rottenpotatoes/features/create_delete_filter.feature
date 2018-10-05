Feature: create, delete, sort and filter a movie
 Background: movies in database
 
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
 Scenario: creating a new movie
  When I am on the RottenPotatoes home page
  And  I follow "Add new movie"
  And  I fill in "Title" with "Avengers: Infinity Wars"
  And  I select "PG-13" from "Rating"
  And  I select "2018" from "movie_release_date_1i"
  And  I select "April" from "movie_release_date_2i"
  And  I select "27" from "movie_release_date_3i"
  And  I press "Save Changes" 
  Then I should see "Avengers: Infinity Wars was successfully created"
  And  I should see "PG-13"
  And  I should see "2018-04-27" 

 Scenario: sorting by movie title
  When I am on the RottenPotatoes home page
  And I follow "Movie Title"
  Then I should see "Alien" before "Blade Runner"


 Scenario: sorting by release date
  When I am on the RottenPotatoes home page
  And I follow "Release Date"
  And I check the following ratings: R
  And I press "ratings_submit"
  Then I should see "THX-1138" before "Alien"
  
 Scenario: destroying a movie
  When I am on the details page for "Star Wars"
  And  I press "Delete"
  Then I should see "Movie 'Star Wars' deleted."
  And  I should not see "1977-05-25"
  
 Scenario: destroying a movie
  When I am on the details page for "Blade Runner"
  And  I press "Delete"
  Then I should see "Movie 'Blade Runner' deleted."
  And  I should not see "Ridley Scott"
