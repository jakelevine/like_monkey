class User < ActiveRecord::Base


	#on_heroku
	API_KEY = ENV['API_KEY']
	API_SECRET = ENV['API_SECRET']

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
		name = user.name	
		
		info = access_token.get("http://api.tumblr.com/v2/user/info")
		infoJSON = JSON.parse(info.body)
		following = infoJSON["response"]["user"]["following"]

		#timestorun = Integer(following)/20+1
		timestorun = 2
		names = []
		n = 0
		while n < timestorun do
			response = access_token.get("http://api.tumblr.com/v2/user/following?offset="+(n*20).to_s)
			final = JSON.parse(response.body)
			final["response"]["blogs"].each do |blog|
				names.push(blog["name"])
			end
			n+=1
		end
		user.following = names
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
			
			if final["meta"]["status"] == 200 and final["response"]["liked_posts"].count > 5
				likes = []
				final["response"]["liked_posts"].each do |like|
					likes.push([like["slug"], like["post_url"], like["blog_name"], like["date"]])
				end
			likehash[name] = likes
			end
		end
		return likehash
	end

	def self.get_following_likes_all(user)
		access_token = User.prepare_access_token(user)
		
		like_array = Array.new

		user.following.each do |name|

			url = "http://api.tumblr.com/v2/blog/"+name+".tumblr.com/likes?api_key="+API_KEY
			response = access_token.get(url)			
			final = JSON.parse(response.body)
			

			if final["meta"]["status"] == 200 and final["response"]["liked_posts"].count > 2
				final["response"]["username"] = name
				like_array.push(final["response"])
			end
		
		end
		user.following_likes = like_array
		user.save
		return like_array

			
	end 

	def self.get_sorted_by_date(response)
		
		post_array = Array.new
		response.each do |blog|
			blog["liked_posts"].each do |post|
				post["username"] = blog["username"]
				post_array.push(post)				
			end
		end
		return post_array.sort_by {|hash| hash["timestamp"]}.reverse

	 

	end







end