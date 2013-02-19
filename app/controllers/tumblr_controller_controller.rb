class TumblrControllerController < ApplicationController
	def recent_likes
        # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.

		
		response = User.get_following(current_user)
		
		likes = User.get_following_likes(current_user)
		@likes = likes
		return @likes
    end

end
