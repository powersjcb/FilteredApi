class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :street, null: false
      t.string :status, null: false
      t.integer :price, null: false
      t.integer :bedrooms, null: false
      t.integer :bathrooms, null: false
      t.integer :sq_ft, null: false
      t.float :lat, null: false
      t.float :lng, null: false

      t.timestamps null: false
    end

    add_index :houses, :price
    add_index :houses, :bedrooms
    add_index :houses, :bathrooms
    add_index :houses, :sq_ft
  end
end

# id,street,status,price,bedrooms,bathrooms,sq_ft,lat,lng
