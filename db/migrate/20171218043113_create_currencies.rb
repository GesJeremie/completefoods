class CreateCurrencies < ActiveRecord::Migration[5.1]
  def up
    create_table :currencies do |t|
      t.string :symbol
      t.string :name

      t.timestamps
    end

    add_index :currencies, [:symbol], unique: true
  end

  def down
    drop_table :currencies
  end
end
