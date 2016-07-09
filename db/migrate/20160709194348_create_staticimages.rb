class CreateStaticimages < ActiveRecord::Migration
  def change
    create_table :staticimages do |t|
      t.string :staticpic

      t.timestamps null: false    	
    end
  end
end
