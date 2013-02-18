require 'tweetstream'

TweetStream.configure do |config|
    config.consumer_key = '0XrIktKc0F61T1ZCc8ZB9A'
    config.consumer_secret = 'W2zePCtZhTgz9sgYizZuiDuSGnaJTabo4tFCVyoyGWM'
    config.oauth_token = '961450039-TVr0ceR1NNRh2WKWgfwZdc66p3HEntcmjh0wCOOA'
    config.oauth_token_secret = 'qsOCVC2i8DaIjcML8Tk5AHNLpUpedCbf9nxejdznaJ8'
    config.auth_method = :oauth
end

	puts "Beginning stream..."	
	begin
		#approximating the lat and long of the lower 48 US -125,20,-125,50,-70,25,-70,50
#	TweetStream::Client.new.sample do |status, client|
	TweetStream::Client.new.locations('-74,40,-73,41') do |status, client|
		data = {"created_at" => Time.parse(status.created_at), "text" => status.text, "geo" => status.geo, "coordinates" => status.coordinates, "id" => status.id, "id_str" => status.id_str}
		puts data.to_s
	end
	rescue Interrupt
			puts "Closing connection..."
	end
#	TweetStream::Daemon.new.on_error do |message|
#		puts "An error occurred..."
#	end.filter({"locations" => "-125.00, 20.00, -125.00, 50.00, -70.00, 25.00, -70.00, 50.00"}) do |status|
	  # Do things when nothing's wrong
#	  puts data.to_s
#	end

