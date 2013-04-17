module Admin::Companies::VacancyHelper
  def helpers_class(company)
    class_submit = case company.state
      when "draft", "pending", "rejected" then "disable input-sub btn btn-warning"
      else "input-sub btn btn-warning"
    end
    
    return class_submit
  end
end
