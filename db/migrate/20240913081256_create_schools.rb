class CreateSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :short_name
      t.string :location
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
