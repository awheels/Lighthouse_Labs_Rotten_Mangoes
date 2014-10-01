class MoviesController < ApplicationController
  def index
    case params[:sort]
      when "newest"
        @movies = Movie.order(:created_at)
      when "title"
        @movies = Movie.order(:title)
      when "averagerating" 
        @movies = Movie.all.select{|movie| movie.reviews.count != 0}
        @movies = @movies.sort{|x,y| y.review_average <=> x.review_average}
      else 
        @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :genre
    )
  end
end