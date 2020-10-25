class Movie < ActiveRecord::Base
  def self.all_ratings 
    return ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings, sort_by)
    if ratings.length == 0
      movies = Movie.all()
    else 
      movies = Movie.where('rating IN (?)', ratings)
    end 
    
    if sort_by
      movies = movies.order(sort_by)
    end 
    
    return movies
  end
  
end
