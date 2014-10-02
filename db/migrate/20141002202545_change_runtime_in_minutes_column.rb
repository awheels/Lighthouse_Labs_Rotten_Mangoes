class ChangeRuntimeInMinutesColumn < ActiveRecord::Migration
  def change
    change_column :movies, :runtime_in_minutes, :integer
  end
end
