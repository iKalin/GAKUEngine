module Gaku
	module SheetHelper

    def translate_fields(fields)
	    translated_fields = []
	    fields.each do |field|
	      translated_fields << I18n.t('csv.fields.' + field)
	    end
	    return translated_fields
	  end

    def registration_fields
      %w(surname name surname_reading name_reading gender phone email birth_date admitted)
    end
    
	end
end
