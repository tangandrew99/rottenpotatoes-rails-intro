class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    
    @ratings_to_show = session[:ratings_to_show] || []
    @sort_by = session[:sorted_by]
    
    if params.include?(:home) || params[:commit] == "Refresh"
      @ratings_to_show = []
      if params[:ratings]
        @ratings_to_show = params[:ratings].keys
      end 

      if params[:sort_by]
      @sort_by = params[:sort_by]
      end 
    end
    
    session[:ratings_to_show] = @ratings_to_show
    session[:sorted_by] = @sort_by
    
    @movies = Movie.with_ratings(@ratings_to_show, @sort_by)
  end

  def new
    # default: render 'new' template
    @all_ratings = []
  end

  def create
    @movie = Movie.create!(movie_params)
    @all_ratings = ['G','PG','PG-13','R']
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
