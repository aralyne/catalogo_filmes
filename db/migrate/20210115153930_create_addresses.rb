class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :cep
      t.string :city
      t.string :neighborhood
      t.string :number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
