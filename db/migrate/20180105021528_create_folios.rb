class CreateFolios < ActiveRecord::Migration[5.1]
  def up
    create_table :folios do |t|
      t.references :user

      t.timestamps
    end
  end

  def down
    drop_table :folios
  end
end
