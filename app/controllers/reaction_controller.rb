class ReactionController < ApplicationController

    def create
        reaction = Reaction.find_or_create_by(user_id: params[:user_id], opinion_id: params[:opinion_id])
        if reaction
            reaction.kind = params[:type]
            reaction.save
            data = {message: "SUCCESS"}
        else
            data = {message: "FAILURE"}
        end
        render :json => data
    end

end
