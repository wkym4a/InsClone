class AddIndexUserToPictures < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :pictures, :users
  end
end
