class CreateGakuSimpleGrades < ActiveRecord::Migration
  def change
  	create_table :gaku_simple_grades do |t|
      t.string      :name
      t.string      :grade
      t.references  :school
      t.references  :student

      t.timestamps
  	end
  end
end
