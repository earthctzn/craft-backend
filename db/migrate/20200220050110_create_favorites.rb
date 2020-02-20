class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.boolean :isfavorite, :default => false

      t.timestamps
    end
  end
end
