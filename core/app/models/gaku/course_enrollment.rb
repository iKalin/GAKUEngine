# == Schema Information
#
# Table name: course_enrollments
#
#  id         :integer          not null, primary key
#  student_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Gaku
  class CourseEnrollment < ActiveRecord::Base
    belongs_to :student
    belongs_to :course
    
    validates :student_id, :uniqueness => {:scope => :course_id, :message => "Already enrolled to course!"}
    validates_presence_of :course_id

    attr_accessible :student_id, :course_id
    #scope

    #def self.get_enrolled(course_id)
    #  CourseEnrollment.where({:course_id => course_id})
    #end

    #def self.get_not_enrolled(course_id)
    #  CourseEnrollment.lambda({ |
    #end
  end
end
