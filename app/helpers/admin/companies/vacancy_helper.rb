module Admin::Companies::VacancyHelper
  def helpers_class(company)
    class_submit = case company.state
      when "draft", "pending", "rejected" then "disable"
      else "save_edit_button"
    end
    
    return class_submit
  end
end
