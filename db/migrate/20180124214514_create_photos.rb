class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.belongs_to :subject
      t.date :date
      t.string :image_url
      t.string :notes
      t.timestamps
    end
  end
end
