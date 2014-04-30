require 'yaml'
require 'open-uri'
require './gtfs-realtime.pb.rb'
require 'active_support/all'

def pretty_print_time( time_in_seconds )
	time_in_seconds = time_in_seconds.to_i
	hours,   seconds = time_in_seconds.divmod( 3600 )
	minutes, seconds = seconds.divmod( 60 )

	if hours > 0
		time = "#{hours}:#{minutes.to_s.rjust(2, '0')}"
	else
		time = "#{minutes}"
	end
	time += ":#{seconds.to_s.rjust(2, '0')}"
end

def get_message( time_in_seconds )
	message = "You've got tonnes of time!"
	if time_in_seconds < 1.minute
		message = "You're outta time, go catch your train!"
	elsif time_in_seconds < 5.minutes
		message = "Grab a slice"
	elsif time_in_seconds < 20.minutes
		message = "Grab a panzerotti"
	elsif time_in_seconds < 40.minutes
		message = "Why not have a full meal?"
	end

	return message
end

url = 'http://datamine.mta.info/mta_esi.php?key=ffe469dfc0feff9c087568bc4c2d1e95'

data = FeedMessage.decode( open( url ).read )

procData = Hash.new
procData['header'] = data['header'].to_hash
procData['trips'] = Hash.new

your_stop = 'L29N'

# stops = 0
data['entity'].each_with_index do |t, i|
	next if t.nil? or t['trip_update'].nil? or t['trip_update']['trip'].nil?

	trip_update = t['trip_update']

	if trip_update['stop_time_update'].class == Array
		trip_update['stop_time_update'].each do |stop_time_update|
			next if stop_time_update.stop_id != your_stop

			route = trip_update.trip.route_id
			departure_time = Time.at( stop_time_update.departure.time )
			diff = ( departure_time - Time.now ).to_i

			puts "The #{route}-Train is departing in #{ pretty_print_time(diff) }"
			puts "- #{get_message( diff )}"
		end
	end
end

puts
