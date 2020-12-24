class TopicController < ApplicationController
    def getnew
        topics = Topic.order(created_at: :desc).page(params[:page])
        last = Topic.order(created_at: :desc).page(params[:page]).last_page?
        render :json => {message: "Success", topics: topics, last: last}
    end

    def getpopular
        topics = Topic.order(score: :desc).page(params[:page])
        last = Topic.order(score: :desc).page(params[:page])
        render :json => {message: "Success", topics: topics, last: last}
    end


    def liketopics
        topics = Topic.all.filter{|topic| topic.title.downcase.include?(params[:input].downcase)}
        render :json => {topics: topics.first(10)}
    end

    def create
        topic = Topic.new(topic_params)
        if topic.save
            data = {message: "Success", topic: topic}
        else
            data = {message: "Could not create topic."}
        end
        render :json => data
    
    end

    def wordcloud
        topic = Topic.find_by(title: params[:id])
        opinions = topic.opinions
        tally = {}
        opinions.each do |opinion|
            opinion.content.split(' ').each do |word|
                word = word.downcase.split('').filter{|letter| "abcdefghijklmnopqrstuvwxyz".include? letter}.join('')
                if !["the","if","is","a","of","as","in","it","i","im","you","my","its","but"].include?(word)
                    tally["#{word}"] ||= 0
                    tally["#{word}"] += 1
                end
            end
        end
        tally = tally.sort_by{|word, value| value}.reverse.map{|word|word}
        new_tally = []
        tally.each_with_index do |word,index|
            new_tally[index] = {text: word[0], value: word[1]}
        end
        new_tally = new_tally.slice(0, params[:resolution].to_i)


        render :json => new_tally
    end


    def topicnewopinions
        topic_id = Topic.find_by(title: params[:id]).id
        opinions = Opinion.where({topic_id: topic_id}).order(created_at: :desc).page(params[:page])
        last = Opinion.where({topic_id: topic_id}).order(created_at: :desc).page(params[:page]).last_page?
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user: opinion.user.name,
            topic: opinion.topic.title,
            id: opinion.id,
            created_at: opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, topic: topic_id, last: last}
    end

    def topicpopularopinions
        topic_id = Topic.find_by(title: params[:id]).id
        opinions = Opinion.where({topic_id: topic_id}).order(positivity: :desc).page(params[:page])
        last = Opinion.where({topic_id: topic_id}).order(positivity: :desc).page(params[:page]).last_page?
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user: opinion.user.name,
            topic: opinion.topic.title,
            id: opinion.id,
            created_at: opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, topic: topic_id, last: last}
    end

    def topicweirdopinions
        topic_id = Topic.find_by(title: params[:id]).id
        opinions = Opinion.where({topic_id: topic_id}).order(weird: :desc).page(params[:page])
        last = Opinion.where({topic_id: topic_id}).order(weird: :desc).page(params[:page]).last_page?
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user: opinion.user.name,
            topic: opinion.topic.title,
            id: opinion.id,
            created_at: opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, topic: topic_id, last: last}
    end

    def show
        # byebug
            topic = Topic.find_by(title: params[:id])
        if topic
            # byebug
            opinions = topic.opinions.map{|opinion| 
                {
                    reactions: opinion.reactions.map{|reaction| reaction.kind},
                    user: opinion.user.name,
                    topic: topic.title,
                    created_at: opinion.created_at,
                    content: opinion.content,
                    id: opinion.id
                }
            }
            data = {message: "Success", :topic => {title: topic.title, id: topic.id, opinions: opinions}}
        else
            data = {message: "Could not access topic"}
        end
        render :json => data
    end
    private
        def topic_params
            params.require(:topic).permit(:title)
        end
end
