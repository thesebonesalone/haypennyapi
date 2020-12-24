require 'pry'
class TopicFeed < ApplicationRecord
    def self.newfeed
        topics = Topic.all
        time = Time.now
        new_topics = []
        topics.each do |topic|
            score = 0
            opinions = topic.opinions
            opinions.each do |opinion|
                diff = time - opinion.created_at
                if diff < 3600
                    score += 100
                elsif diff < 7200
                    score += 90
                elsif diff < 10800
                    score += 75
                elsif diff < 14400
                    score += 50
                elsif diff < 86400
                    score += 25
                else
                    score += 1
                end
            end
            topic.score = score
            topic.save
        end
    end
end
