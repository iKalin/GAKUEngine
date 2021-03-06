class CreateGakuAdmissionPhaseStates < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phase_states do |t|
      t.string      :name
      t.boolean     :can_progress
      t.boolean     :can_admit
      t.boolean     :auto_progress
      t.boolean     :auto_admit
      t.boolean     :is_default
      t.references  :admission_phase

      t.timestamps
  	end
  end
end
