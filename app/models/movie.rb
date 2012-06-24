class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  class << self
    def by_movie_director(name)
      where(director: name)
    end
  end
end
