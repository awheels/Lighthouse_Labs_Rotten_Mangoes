class Movie < ActiveRecord::Base
  scope :with_keywords, -> (s){where("title like ? or director like ?", "%#{s}%", "%#{s}%")}
  
  scope :runtime_less_than_90_min, -> {where("runtime_in_minutes < ?", 90)}
  scope :runtime_greater_than_120_min, -> {where("runtime_in_minutes > ?", 120)}
  scope :runtime_between_90_and_120_min, -> {where(runtime_in_minutes: 90..120)}
  
  has_many :reviews, dependent: :destroy 

  validates :title, :director, :genre, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }

  mount_uploader :image, PosterImageUploader

  def self.search(params)
    movies = Movie.all
    if params != nil
      movies = movies.with_keywords(params[:q]) if params[:q]
      movies = movies.runtime_less_than_90_min if params[:duration] == 1.to_s
      movies = movies.runtime_between_90_and_120_min if params[:duration] == 2.to_s
      movies = movies.runtime_greater_than_120_min if params[:duration] == 3.to_s
      movies = movies.order(:created_at) if params[:sort] == 3.to_s
      movies = movies.order(:title) if params[:sort] == 2.to_s
      movies = movies.order(average_rating: :desc) if params[:sort] == 1.to_s
    end
    movies
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size != 0
  end


end
