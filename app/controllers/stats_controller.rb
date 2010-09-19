class StatsController < ApplicationController
  def show
    hash = params[:id]
    id = Base32::Crockford.decode(hash)
    begin 
      @link = Link.find(id)
      @diminutive_url = path_to_url(@link.to_diminutive_url)
      @browsercounts = {:firefox => 0, :ie => 0, :safari=>0, :chrome => 0, :other=>0}
      @oscounts = {:windows => 0, :linux => 0, :macos => 0}
      @link.impressions.each  do |imp|
        logger.info imp.browser
        if imp.browser == :firefox
          @browsercounts[:firefox] = @browsercounts[:firefox] + 1
        elsif imp.browser == :ie
          @browsercounts[:ie] = @browsercounts[:ie] + 1
        elsif imp.browser == :safari
          @browsercounts[:safari] = @browsercounts[:safari] + 1
        elsif imp.browser == :chrome
          @browsercounts[:chrome] = @browsercounts[:chrome] + 1
        elsif imp.browser == :other
          @browsercounts[:other] = @browsercounts[:other] + 1 
        end
        
        if imp.os == :windows
          @oscounts[:windows] = @oscounts[:windows] + 1
        elsif imp.os == :macos
          @oscounts[:macos] = @oscounts[:macos] + 1
        end
      end
    rescue ActiveRecord::RecordNotFound => ex
        logger.error "Error!" << ex.message
        flash[:error] = 'Sorry! We don\'t know about that URL'
        redirect_to '/'
    end
  end

end
