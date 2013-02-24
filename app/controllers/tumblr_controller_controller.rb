class TumblrControllerController < ApplicationController

	caches_action :news_likes

#	caches_page :recent_likes
	
	def recent_likes
        # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
        
		#Rails.cache.fetch(current_user) do
		response = User.get_following(current_user)
		likes = User.get_following_likes(current_user)
		@likes = likes
		return @likes
		#end
    end

    def new_likes

    	@response = Rails.cache.fetch(current_user.name) {
			following = User.get_following(current_user)
			@response = User.get_following_likes_all(current_user)
		}
		@response = Kaminari.paginate_array(@response).page(params[:page]).per(5)    			      		

    end 

end

#render :json => response
