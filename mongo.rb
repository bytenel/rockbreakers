require 'mongo'
require 'json'
include Mongo

db = Connection.new.db("rockbreakers")
tweets = db.collection('tweets')
tweets.remove

dir = Dir.open('tweets')
dir.each { |file|
	puts file
	
	if file == '.' or file == '..'
	    next
	end

	puts "==========================================="
    File.open('tweets/'+file, 'r') do |f|
	puts file
	puts "==========================================="
	f.each_line{|line|
	begin
		line.gsub!(/"geo.*,/, '')
		line.gsub!(/=>/, ':')
		line.gsub!(/\\/, '')
		temp = JSON.parse(line, :symbolize_names => true)
	rescue => e
	    e.to_s
	else
		tweets.insert(temp)	
		puts "==========================================="
		puts line	
		puts "==========================================="
	end
	}
    end	
}
