class Movie < ActiveRecord::Base
  scope :title_and_director, -> (s){where("title like ? or director like ?", s, s)}
  scope :runtime_less_than_90_min, -> {where("runtime_in_minutes < ?", 90)}
  scope :runtime_greater_than_120_min, -> {where("runtime_in_minutes > ?", 120)}
  scope :runtime_between_90_and_120_min, -> {where(runtime_in_minutes: 90..120)}
  
  has_many :reviews

  validates :title, :director, :genre, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_future

  mount_uploader :image, PosterImageUploader

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size != 0
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
