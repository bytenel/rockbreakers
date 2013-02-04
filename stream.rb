require 'tweetstream'

TweetStream.configure do |config|
    config.consumer_key = '0XrIktKc0F61T1ZCc8ZB9A'
    config.consumer_secret = 'W2zePCtZhTgz9sgYizZuiDuSGnaJTabo4tFCVyoyGWM'
    config.oauth_token = '961450039-TVr0ceR1NNRh2WKWgfwZdc66p3HEntcmjh0wCOOA'
    config.oauth_token_secret = 'qsOCVC2i8DaIjcML8Tk5AHNLpUpedCbf9nxejdznaJ8'
    config.auth_method = :oauth
end

TweetStream::Client.new.sample do |status|
    puts "#{status.user.screen_name}: #{status.text}"
end
