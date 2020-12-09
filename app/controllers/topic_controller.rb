class TopicController < ApplicationController
    def show
            topic = Topic.find_by(title: params[:title])
        
        if topic
            data = {message: "Success", :topic => {title: topic.title, opinions: topic.opinions}}
        else
            data = {message: "Could not access topic"}
        end
        render :json => data
    end

end
