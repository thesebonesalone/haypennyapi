class VoteController < ApplicationController
    def create
        vote = Vote.find_or_create_by(user_id: params[:user_id],comment_id: params[:comment_id])
        vote.value = 0
        if vote.save
            vote.update(value: params[:value])
            data = {message: "Success", vote: vote}
        else
            data = {message: "Could not create vote"}
        end
        render :json => data
    end
end