class RenameDeckImagesToImages < ActiveRecord::Migration[5.2]
  def change
    rename_table :deck_images, :images
  end
end
