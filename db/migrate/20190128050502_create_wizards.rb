class CreateWizards < ActiveRecord::Migration[5.2]
  def change
    create_table :wizards do |t|
      t.string :token
      t.timestamps
    end

    add_index :wizards, :token, unique: true
  end
end
