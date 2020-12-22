class VoteController < ApplicationController
    def create
        votes = Vote.where("user_id = ? and comment_id = ?", params[:user_id], params[:comment_id])
        if votes.length > 0
            vote = votes[0]
            vote.destroy
        end
        vote = Vote.new()
        vote.user_id = params[:user_id]
        vote.comment_id = params[:comment_id]
        vote.value = params[:value]
        if vote.save
            data = {message: "Success", vote: vote}
        else
            data = {message: "Could not create vote"}
        end
        render :json => data
    end
end