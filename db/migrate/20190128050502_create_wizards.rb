class CreateWizards < ActiveRecord::Migration[5.2]
  def change
    create_table :wizards do |t|
      t.string :email
      t.string :current_step
      t.jsonb :search_attributes
      t.timestamps
    end
  end
end
