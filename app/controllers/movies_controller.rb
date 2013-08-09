class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @all_ratings = ['G','PG','PG-13','R']
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    if not params[:ratings].nil?
      then
        @ratings = params[:ratings]
        if params[:sort_field]
          then 
            @sort = params[:sort_field]
            @movies = Movie.where("ratings = ?", @ratings).order(params[:sort_field])
          else 
            @movies = Movie.where("ratings = ?", @ratings) 
        end
      else 
      params[:ratings] = {}
      @all_ratings.each do |rating|
        params[:ratings][rating] = 1
      end
      if params[:sort_field]
        then
          @movies = Movie.order(params[:sort_field])
        else
          @movies = Movie.find(:all)
        end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def sort
    redirect_to movies_path
  end

  def filter
    redirect_to movies_path
  end

end
