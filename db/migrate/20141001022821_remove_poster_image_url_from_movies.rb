class RemovePosterImageUrlFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :poster_image_url, :string
  end
end
