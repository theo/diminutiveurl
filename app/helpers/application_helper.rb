# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nice_date(date)
      if date.nil?
        date = Time.now
      end 
      h date.strftime("%m/%d/%Y")
  end
  
end
