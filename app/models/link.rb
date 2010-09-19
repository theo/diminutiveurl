require 'base32/crockford'

class Link < ActiveRecord::Base
  has_many :impressions
  before_save :add_protocol
  validates_uniqueness_of :url
  # url
  validates_format_of :url_with_protocol, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :message=>" is not a valid URL"
  
  def self.url(url)
    Link.where(:url => Link.add_protocol(url)).first()
  end
  
  def url_with_protocol
     Link.add_protocol(self.url)
  end
  
  def to_diminutive_url
    if self.new_record?
      nil
    else
      hash = Base32::Crockford.encode(self.id)
      "/" << hash.downcase
    end 
  end  
  
  private
    def strip_protocol
      self.url = Link.strip_protocol(self.url)
    end
    
    def add_protocol
      self.url = Link.add_protocol(self.url)
    end
    
    def self.strip_protocol(url)
      protocol = 'http://'
      if url.starts_with? protocol
         url = url[protocol.length, url.length]
      end      
      url
    end
    
    def self.add_protocol(url)
       if not url.nil?
          if url.starts_with? 'http://'
            url
          else
            'http://' << url
          end
        else
          url
        end
    end
  
end
