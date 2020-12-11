class TopicController < ApplicationController
    def index
        topics = Topic.all()
        render :json => {message: "Success", topics: topics}
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

end
