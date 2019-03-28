class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :title
      t.text :content
      t.text :image
      t.references :user

      t.timestamps
    end
  end
end
