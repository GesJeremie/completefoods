class CreateCurrencies < ActiveRecord::Migration[5.1]
  def up
    create_table :currencies do |t|
      t.string :code
      t.string :name
      t.string :symbol

      t.timestamps
    end

    add_index :currencies, [:code], unique: true
  end

  def down
    drop_table :currencies
  end
end
