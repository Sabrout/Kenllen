class CreateTestModels < ActiveRecord::Migration
  def change
    create_table :test_models do |t|
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
