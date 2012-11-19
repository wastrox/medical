module ApplicantsHelper

  def validation_errors?(object)
    !object.errors.empty?
  end
  def validation_class_for(object)
    validation_error_class = ""
    validation_error_class = "validation_err" if validation_errors?(object)
  end
	def div_accordion_header_for(object)
    "<div class=\"#{validation_class_for(object)} header\">"
  end
  def div_accordion_content_for(object)
    "<div class=\"#{validation_class_for(object)} fields_inner\">"
  end
  def default_value_for(field, default_val)
    field == nil ? default_val : (field.to_s.size>0 ? field : default_val)
  end
  def link_to_save_fields(name, f)
    link_to_function(name, "hide_fields(this)", :class => "icon icon-accept save_experience")
  end
	def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "icon icon-remove remove_experience")
  end
end
