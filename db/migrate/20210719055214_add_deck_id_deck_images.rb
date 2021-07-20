class AddDeckIdDeckImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :deck_images, :deck, foreign_key: true
  end
end
