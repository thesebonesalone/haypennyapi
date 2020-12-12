class TopicController < ApplicationController
    def index
        topics = Topic.all()
        render :json => {message: "Success", topics: topics}
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

    def show
        # byebug
            topic = Topic.find_by(title: params[:id])
        if topic
            data = {message: "Success", :topic => {title: topic.title, opinions: topic.opinions}}
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
