class TopicController < ApplicationController
    def getnew
        topics = Topic.order(created_at: :desc).page(params[:page])
        last = Topic.order(created_at: :desc).page(params[:page]).last_page?
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
            data = {message: "Success", :topic => {title: topic.title, opinions: opinions}}
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
