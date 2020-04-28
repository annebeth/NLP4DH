$redis = Rails.env.production? ? Redis.new(url: ENV["REDIS_URL"]) : Redis.new(url: "redis://localhost:6379")
