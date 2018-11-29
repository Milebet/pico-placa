class CreateValidators < ActiveRecord::Migration[5.2]
  def change
    create_table :validators do |t|
      t.string :placa
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
