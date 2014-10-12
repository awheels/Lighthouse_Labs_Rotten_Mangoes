class AddAverageRatingToMovies < ActiveRecord::Migration
  def change 
    add_column :movies, :average_rating, :integer
  end
end
