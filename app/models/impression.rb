class Impression < ActiveRecord::Base
  belongs_to :link
  
  def browser
    if self.http_user_agent =~ /Chrome/i
      return :chrome
    elsif self.http_user_agent =~ /MSIE/i
      return :ie 
    elsif self.http_user_agent =~ /Safari/i
      return :safari 
    elsif self.http_user_agent =~ /Firefox/i
      return :firefox 
    else
     return :other
    end
  end
  
  def os
    if self.http_user_agent =~ /Windows NT/
      return :windows
    elsif self.http_user_agent =~ /Mac OS X/
      return :macos
    else
      return :other
    end
  end

  
end
