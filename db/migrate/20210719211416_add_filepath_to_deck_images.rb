class AddFilepathToDeckImages < ActiveRecord::Migration[5.2]
  def change
    add_column :deck_images, :filepath, :string
  end
end
