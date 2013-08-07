class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end
	
	def show
		#id = params[:id]
		@movie = Movie.find(params[:id])
		logger.debug("The id is #{params[:id]}")
	end
	
	
	def index
	  @movies = Movie.all
	
	 if params[:sort_param].nil? && params[:ratings].nil? &&
	    (!session[:sort_param].nil? || !session[:ratings].nil?)
	    redirect_to movies_path(:sort_param => session[:sort_param])
	 end
	 
	  @sort = params[:sort_param]
	  #@ratings = params[:ratings]
	  
           logger.debug("++++++ #{params[:ratings]} {}{}{}{}{} #{params[:sort_param]}")
	  
	  
	  if @sort
	   	
	    @movies = Movie.order("#{@sort} ASC")
	    session[:sort_param] = @sort
	    #debugger
	  end
	
	
        #session[:ratings] = @ratings
	end
	
	def new
		
	end

        def create
		@movie = Movie.create!(params[:movie])	
		redirect_to movies_path
		logger.debug("$$$$ ###### #{movies_path}")
		logger.debug("%%%%% ***** #{params[:movie]}")
	end

	def edit
		@movie = Movie.find(params[:id])
		
	end
	
	def update
		@movie = Movie.find(params[:id])
		@movie.update_attributes!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully updated"
		redirect_to movies_path	
	end
	
	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:notice] = "#{@movie.title} was successfully updated"
		redirect_to movies_path
	end

end
