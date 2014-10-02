class MoviesController < ApplicationController
  def index
    if params[:sort]
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
    elsif params[:search] && params[:duration]
      s = "%#{params[:search]}%"
      if s && params[:duration].empty?
        @movies = Movie.where("title like ? or director like ?", s, s)
      elsif s && params[:duration]
        if params[:duration].to_i == 1
          puts "why is it running into nil"
          @movies = Movie.where("title like ? or director like ?", s, s).where("runtime_in_minutes < ?", 90)
        elsif params[:duration].to_i == 2
          @movies = Movie.where("title like ? or director like ?", s, s).where(runtime_in_minutes: 90..120)
        elsif params[:duration].to_i == 3
          @movies = Movie.where("title like ? or director like ?", s, s).where("runtime_in_minutes > ?", 120)
        end
      end
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
      render :new # app/views/movies/new.html.erb
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
