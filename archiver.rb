require 'rubygems'
require 'mongo'
require 'twitter'

require './config'

class Archiver

  def initialize(tag)
    connection = Mongo::Connection.new
    db = connection[DATABASE_NAME]
    @tweets = db[COLLECTION_NAME]
    @tweets.create_index([['id',1]],:unique=>true)
    @tweets.create_index([['tags',1],['id',-1]])

    @tag = tag
    p 'Tags :'+@tag
    @tweets_found = 0

    config = {
        :consumer_key    => "",
        :consumer_secret => "",
    }


    @client = Twitter::REST::Client.new(config)

  end

  def update
    puts "Starting Tweeter search for '#{@tag}'...."
    save_tweets_for(@tag)
    print "#{@tweets_found} tweets saved.\n\n"
  end

  def save_tweets_for(term)
    @client.search(term, :result_type => "recent").take(20).each do |tweet|
      @tweets_found +=1
      tweet_with_tag = tweet.to_h.merge!({"tags" => [term]})
      @tweets.save(tweet_with_tag)
    end
  end
end