class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :provide_stats
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b803ef0ac0e82215be6df238c3ab6e99'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def provide_stats
    @num_links = Link.count
    @clickthroughs = Link.sum(:count)
    @since = Link.minimum(:created_at)
  end
  
  protected
  
  def path_to_url(path)
      host = request.host_with_port
      if host.starts_with? "www."
        host=host[4,host.length]
      end
      url = request.protocol + host  + path
      
  end
end
