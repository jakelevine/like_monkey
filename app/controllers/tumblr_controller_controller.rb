class TumblrControllerController < ApplicationController

	
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

    def sort_by_time
		@response = Rails.cache.fetch(current_user.name) {
			following = User.get_following(current_user)
			@response = User.get_following_likes_all(current_user)
		}
		@sorted_by_time = User.get_sorted_by_date(@response)
		@sorted_by_time = Kaminari.paginate_array(@sorted_by_time).page(params[:page]).per(50)    			      		
		
		return @response, @sorted_by_time

		#Next: Add better UI for toggling friends/date
			#Show who Liked each post

	end 
end

#render :json => response
