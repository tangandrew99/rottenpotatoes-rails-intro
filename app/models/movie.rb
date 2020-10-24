class Movie < ActiveRecord::Base
  def self.all_ratings 
    return ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings)
    if ratings.length == 0
      return Movie.all()
    end
    return Movie.where('rating IN (?)', ratings)
  end
end
