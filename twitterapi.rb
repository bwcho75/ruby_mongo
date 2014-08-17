require 'twitter'

config = {
    :consumer_key    => "MQxyEF2cAYRGEBZV8Yaf1wO9e",
    :consumer_secret => "iw4xIl9qkdkpTyEu13pQ3Ipw99zNEIv6Nz2IsBx0hYGC8S0Drp",
}

client = Twitter::REST::Client.new(config)

client.search("mongodb", :result_type => "recent").take(20).each do |tweet|
  puts "["+tweet.text+"]\n"
end