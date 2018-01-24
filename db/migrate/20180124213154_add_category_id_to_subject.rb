class AddCategoryIdToSubject < ActiveRecord::Migration[5.1]
  def change
    change_table :subjects do |t|
      t.belongs_to :category
    end
  end
end
