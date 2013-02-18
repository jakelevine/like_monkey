class User < ActiveRecord::Base

	API_KEY = '0GMVFegjf6D0cyWTCP6ilhgYwokPRh3Fgy8TvA4mMcez6pmhiJ' 
	API_SECRET = 'G6IHgthYTBmMyupTGO1yxQlmb7c91s6f9sONOakZuejyfayxlA'


	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	    user.token = auth["credentials"]["token"]
		user.secret = auth["credentials"]["secret"]
	  end
	end

	def self.addurls(urls)
		user.urls = urls
	end

	def self.prepare_access_token(user)
		consumer = OAuth::Consumer.new(API_KEY, API_SECRET, {
			:site => "http://www.tumblr.com/"
			})

#		token_hash = {:oauth_token => user.token,:oauth_token_secret => user.secret}

		access_token = OAuth::AccessToken.new(consumer, user.token, user.secret )

	end

	def self.get_following(user)
		access_token = User.prepare_access_token(user)
		response = access_token.get("http://api.tumblr.com/v2/user/following")
		final = JSON.parse(response.body)
		urls = []
		final["response"]["blogs"].each do |blog|
			urls.push(blog["name"])
		end
		user.following = urls
		user.save
		return user.following
	end

	def self.get_following_likes(user)
		access_token = User.prepare_access_token(user)
		
		likehash = Hash.new		
		
		user.following.each do |name|
			url = "http://api.tumblr.com/v2/blog/"+name+".tumblr.com/likes?api_key="+API_KEY
			response = access_token.get(url)			
			final = JSON.parse(response.body)
			
			if final["meta"]["status"] == 200
				likes = []
				final["response"]["liked_posts"].each do |like|
					likes.push([like["slug"], like["post_url"], like["blog_name"], like["date"]])
				end
			likehash[name] = likes
			end
		end
		return likehash
	end

end