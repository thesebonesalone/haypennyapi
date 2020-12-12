class OpinionController < ApplicationController
    def getnew
        opinions = Opinion.order(created_at: :desc).page(params[:page])
        # byebug
        opinions = opinions.map{|opinion| {
            reactions: opinion.reactions.map{|reaction| reaction.kind},
            content: opinion.content, user:opinion.user.name,
            topic:opinion.topic.title,
            id:opinion.id,
            created_at:opinion.created_at}}
        render :json => {message: "Success", opinions: opinions}
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
