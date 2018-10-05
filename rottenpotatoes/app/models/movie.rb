class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def same_director
    Movie.where(:director => director) if (not director.nil?) and (not director.empty?)
  end
end
