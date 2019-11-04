ActiveAdmin.register Wizard do
    index do
    column :id
    column :finished do |wizard|
      wizard.finished?
    end
    column :created_at
    column :updated_at

    actions
  end
end
