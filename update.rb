require './config'
require './archiver'

TAGS.each do |tag|
  archive = Archiver.new(tag)
  archive.update
end