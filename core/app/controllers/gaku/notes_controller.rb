module Gaku
  class NotesController < ApplicationController

  	before_filter :load_notable
    
    inherit_resources

    actions :index, :show, :new, :create, :update, :edit, :destroy

    def index
    	@notes = @notable.notes
      render 'index'
    end

    def new
      @note = @notable.notes.new
      render 'new', :locals => {:notable_resource => @notable_resource}
    end

    def create
    	@note = @notable.notes.new(params[:note])
    	@note.save
      flash.now[:notice] = t('notes.created')
    	render 'create', :locals => {:notable_resource => @notable_resource}
    end

    def edit
      super do |format|
        format.js {render 'edit'}  
      end  
    end

    def show
      @note = Note.find(params[:id])
      super do |format|
        format.js {render 'show'}  
      end  
    end
    
    def update
      super do |format|
        format.js { render 'update' }  
      end  
    end

    def destroy
      @note = Note.find(params[:id])
      @note.destroy
      flash.now[:notice] = t('notes.destroyed')
      respond_to do |format|
        format.js { render 'destroy', :locals => {:notable_resource => @notable_resource} }
      end
    end

  private
  	def load_notable
      klass = [Student, LessonPlan, Syllabus, ClassGroup, Course, Exam].detect { |c| params["#{c.name.underscore}_id"] }
      @notable = klass.find(params["#{klass.name.underscore}_id"])
      @notable_resource = @notable.class.to_s.underscore.gsub("_","-")
  	end

  end
end