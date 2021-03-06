# == Schema Information
#
# Table name: lesson_plans
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  syllabus_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Gaku
	class LessonPlan < ActiveRecord::Base
		has_many :lessons
		has_many :notes, as: :notable
	  has_many :attachments, :as => :attachable
		belongs_to :syllabus
		
		attr_accessible :title, :description
	end
end
