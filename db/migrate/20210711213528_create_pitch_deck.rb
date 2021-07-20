class CreatePitchDeck < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.string :project
      t.string :company
      t.string :pitch_deck_file
      t.string :version
      t.string :file

      t.has_attached_file :pitch_deck

      t.timestamps
    end
  end
end
