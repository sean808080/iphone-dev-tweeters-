# This script is designed to read the twitter using iPhone developers here -> http://is.gd/hlhV and follow them with your twitter account
# plug in your google and twitter account details below
# Credit for this script goes to David Clements
# See his blog post here -> http://shortpath.blogspot.com/2009/01/follow-over-100-iphone-developers-on.html
# Script updated by @sean808080 to resolve auth changes at twitter and use new google gem
# You'll need the google spreadsheet gem (http://github.com/gimite/google-spreadsheet-ruby/tree/master) and the twitter gem
# You may want to change the 1..1000 below so it only adds 10 followers at a time (every hour or so). Twitter will like you more then


require 'rubygems'
require 'twitter'
require 'oauth'
require "google_drive"
GoogleSpreadsheet = GoogleDrive

google_user = "xxx"
google_pw   = "xxx"
twitter_user  = "xxx"
twitter_pw    = "xxx"

session = GoogleSpreadsheet.login(google_user, google_pw)

ws = session.spreadsheet_by_key("p3LA_Q08eM-VAAyq03ZSjYQ").worksheets[0]


#And use the following code to connect to Twitter:
require 'twitter'
Twitter.configure do |config|
config.consumer_key = 'xxx'
config.consumer_secret = 'xxx'
config.oauth_token = 'xxx'
config.oauth_token_secret = 'xxx'
end

base = Twitter::Client.new

(1..1500).each do |row|
        url = ws[row,2]
        matched_user = url.match(/http:\/\/.*twitter.com\/(.*)/)
        next unless matched_user
        matched_user = matched_user[1]

        puts "Attempting to follow #{matched_user}"

        begin
                #base.create_friendship(matched_user)
        			base.friendship_create(matched_user)
                puts "success"
        rescue
                puts "******* Failed  #{$!.message}"
        end
end

