class MoviesController < ApplicationController
  def index
    case params[:sort]
      when "newest"
        @movies = Movie.order(:created_at)
      when "title"
        @movies = Movie.order(:title)
      when "averagerating" 
        @movies = Movie.all.sort{|x,y| (y.review_average || 0) <=> (x.review_average || 0)}
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
      :title, :release_date, :director, :runtime_in_minutes,:remote_image_url, :poster_image_url, :image, :description, :genre
    )
  end
end
