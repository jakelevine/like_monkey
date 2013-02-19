Rails.application.config.middleware.use OmniAuth::Builder do
  #on local
  #provider :tumblr, '0GMVFegjf6D0cyWTCP6ilhgYwokPRh3Fgy8TvA4mMcez6pmhiJ', 'G6IHgthYTBmMyupTGO1yxQlmb7c91s6f9sONOakZuejyfayxlA'
  
  #on heroku
  provider :tumblr, 'ZozRvHImkaTAbHr2VKeQ4cMlzAmI77wjHc4gRT2CMzMDoatBqj', 'y4JJuYmOma0BaFNKHeJYSlIJ4bY2UeZiwjIDt6LxbvHPrynUyI'
  provider :twitter, 'U6yihUf26u2039yK1eNjSg', '6sfCeo32sT9zk5bTgFbjzYwNxKpTK62lEGl6nNy8wo'

end
