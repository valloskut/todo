class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.string :title
      t.integer :priority
      t.date :due_date
      t.boolean :completed
      t.references :user

      t.timestamps
    end
  end
end
