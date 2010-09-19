require 'base32/crockford'


class LinksController < ApplicationController
  # GET /links
  # GET /links.xml
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    hash = params[:id]
    if hash.nil?
      redirect_to '/'
    else
      id = Base32::Crockford.decode(hash.upcase)
      begin 
        @link = Link.find(id)
        @link.count = @link.count + 1
        impressionattributes = Hash.new
        
        impression = Impression.new;
        impression.attributes.each_key { |key|
          impressionattributes[key] = request.env[key.upcase]
        }
        
        impression.attributes = impressionattributes
        @link.impressions << impression
        @link.save
        redirect_to @link.url
      rescue ActiveRecord::RecordNotFound => ex
        logger.error "Error!" << ex.message
        found = false
        flash[:error] = 'Sorry! We don\'t know about that URL'
        redirect_to '/'
      end
    end
     
     
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end
  
  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])
    logger.debug "url: " << @link.url
    if not Link.url(@link.url).nil?
      logger.debug 'URL: ' << @link.url << ' already exists'
      @link = Link.url(@link.url)
      respond_to do |format|
          flash[:notice] = 'Your URL is a lot cooler now!'
          format.html { redirect_to :action => "link", :id => Base32::Crockford.encode(@link.id).downcase }
      end 
    else
      respond_to do |format|
        if @link.save
          flash[:notice] = 'Your URL is a lot cooler now!'
          format.html { redirect_to :action => "link", :id => Base32::Crockford.encode(@link.id).downcase }
        
        else
          format.html { render :action => "new" }
        end
      end
    end
  end
  
  def link
    hash = params[:id]
    id = Base32::Crockford.decode(hash)
    begin 
      @link = Link.find(id)
      @diminutive_url = path_to_url(@link.to_diminutive_url)
    rescue ActiveRecord::RecordNotFound => ex
      logger.error "OH NO!" << ex.message
    end    
    respond_to do |format|
      format.html # link.html.erb
      format.xml  { render :xml => @links }
    end
  end
  
  
  

end
