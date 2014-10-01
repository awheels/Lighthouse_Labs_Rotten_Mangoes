class AddRemoteImageUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :remote_image_url, :string
  end
end
