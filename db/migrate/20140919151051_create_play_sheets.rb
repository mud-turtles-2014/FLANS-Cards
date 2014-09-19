class CreatePlaySheets < ActiveRecord::Migration
  def change
    create_table :playsheets do |t|
      t.belongs_to :round
      t.belongs_to :card
      t.boolean :played, default: false
      t.timestamps
    end
  end
end
