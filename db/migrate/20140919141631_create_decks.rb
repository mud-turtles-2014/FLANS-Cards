class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
       t.string :name
       t.belongs_to :user
       t.boolean :is_public, default: true
       t.timestamps
     end
  end
end
