class CreateWizardSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :wizard_steps do |t|
      t.references :wizard
      t.string :name
      t.boolean :completed, default: false
      t.jsonb :answers
      t.timestamps
    end
  end
end
