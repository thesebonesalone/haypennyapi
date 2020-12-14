class OpinionController < ApplicationController
    def getnew
        opinions = Opinion.order(created_at: :desc).page(params[:page])
        last = Opinion.order(created_at: :desc).page(params[:page]).last_page?
        # byebug
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user:opinion.user.name,
            topic:opinion.topic.title,
            id:opinion.id,
            created_at:opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, last: last}
    end

    def getpopular
        opinions = Opinion.where({created_at: (Time.now - 2.day)..Time.now }).order(positivity: :desc).page(params[:page])
        last = Opinion.order(positivity: :desc).page(params[:page])
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user:opinion.user.name,
            topic:opinion.topic.title,
            id:opinion.id,
            created_at:opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, last: last}
    end

    def getweird
        opinions = Opinion.where({created_at: (Time.now - 2.day)..Time.now }).order(weird: :desc).page(params[:page])
        last = Opinion.order(positivity: :desc).page(params[:page])
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user:opinion.user.name,
            topic:opinion.topic.title,
            id:opinion.id,
            created_at:opinion.created_at}}
        render :json => {message: "Success", opinions: opinions, last: last}
    end



    def userhasopinion
        opinion = Opinion.find_by(user_id: params[:user_id], topic_id: params[:topic_id])
        if opinion
            opinion = {
                reactions: opinion.reactions.map{|reaction| reaction.kind},
                content: opinion.content,
                user: opinion.user.name,
                topic: opinion.topic.title,
                id: opinion.id,
                created_at: opinion.created_at
            }
        end
        render :json => {opinion: opinion}
    end


    def show
        opinion = Opinion.find_by(id: params[:id])
        if opinion
            data = {message: "Success", opinion: {content: opinion.content, user: opinion.user.name, topic: opinion.topic.title}}
        else
            data = {message: "Could not retrieve opinion"}
        end
        render :json => data
    end

    def create
        opinion = Opinion.new(opinion_params)
        # byebug
        if opinion.save
            data = {message: "Success", opinion: opinion}
        else
            data = {message: "Could not make Opinion"}
        end
        render :json => data
    end

    private
        def opinion_params
            params.require(:opinion).permit(:content, :user_id, :topic_id)
        end

end
