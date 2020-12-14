class ReactionController < ApplicationController

    def create
        reaction = Reaction.find_or_create_by(user_id: params[:user_id], opinion_id: params[:opinion_id])
        if reaction
            reaction.kind = params[:type]
            reaction.save
            data = {message: "SUCCESS"}
            opinion = Opinion.find_by(id: reaction.opinion_id)
            reactions = opinion.reactions
            positive = 0
            weird = 0
            reactions.each do |reaction|
                case reaction.kind
                when "LOVE"
                    positive += 5
                when "LAUGH"
                    positive += 3
                    weird += 2
                when "LIKE"
                    positive += 1
                when "DISLIKE"
                    positive -= 2
                when "ANGRY"
                    positive -= 5
                when "CONFUSED"
                    weird += 4
                end   
            end
            opinion.positivity = positive
            opinion.weird = weird
            opinion.save
        else
            data = {message: "FAILURE"}
        end
        render :json => data
    end

end
