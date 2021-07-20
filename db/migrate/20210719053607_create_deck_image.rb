class CreateDeckImage < ActiveRecord::Migration[5.2]
  def change
    create_table :deck_images do |t|
      t.string :filename

      t.timestamps
    end
  end
end
