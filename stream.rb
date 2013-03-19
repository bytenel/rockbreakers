#should stream everything correctly
require 'tweetstream' 
require 'open-uri'

TweetStream.configure do |config|
    config.consumer_key = '0XrIktKc0F61T1ZCc8ZB9A'
    config.consumer_secret = 'W2zePCtZhTgz9sgYizZuiDuSGnaJTabo4tFCVyoyGWM'
    config.oauth_token = '961450039-TVr0ceR1NNRh2WKWgfwZdc66p3HEntcmjh0wCOOA'
    config.oauth_token_secret = 'qsOCVC2i8DaIjcML8Tk5AHNLpUpedCbf9nxejdznaJ8'
    config.auth_method = :oauth
end
    t = Time.new()
    Dir.mkdir("tweets") unless Dir['tweets']
    filename = t.strftime('%Y%m%d%H%M%S').to_s
    filename = 'tweets/'+filename+'.txt'
    f = File.new(filename, 'w')

puts "Beginning stream..."	
     begin
       TweetStream::Client.new.on_error do |message|
		puts "An error occurred...#{message}"
	      f.puts "An error occurred...#{message}"
	      f.close
	      exit(1)
	   end.locations('-125.00','25.00','-70.00','50.00',nil) do |status, client|
		data = {"text" => status.text, "geo" => status.geo, "id" => status.id, "created_at" => status.created_at, "user" => status.user }
		if f.size < 2000000 
		    f.puts data.to_s
		else
		    f.close
		    filename = t.strftime('%Y%m%d%H%M%S').to_s
		    filename = 'tweets/'+filename+'.txt'
		    f = File.new(filename, 'w')
		    f.puts data.to_s
		end

		puts data.to_s
	end
	rescue Interrupt
			puts "Closing connection..."
			f.close
	end

     f.close
