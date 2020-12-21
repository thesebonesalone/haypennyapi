class CommentController < ApplicationController
    def create
        comment = Comment.new()
        comment.user = User.find(params[:user_id])
        comment.opinion = Opinion.find(params[:opinion_id])
        comment.content = params[:content]
        if comment.save
            data = {message: "Success", comment: comment}
        else
            data = {message: "Could not create comment"}
        end
        render :json => data
    end

    def usercomments
        comments = Comment.where("user_id = ? ", params(:id))
        if comments
            data = comments.map{|comment| {
                content: comment.content,
                user: comment.user.name,
                created_at: comment.created_at
            }}
        else
            data = []
        end
        render :json => {message: "Success", comments: data}
    end

    def opinioncomments
        comments = Comment.where("opinion_id = ?", params[:id])
        if comments
            data = comments.map{|comment| {
                content: comment.content,
                user: comment.user.name,
                created_at: comment.created_at
            }}
        else
            data = []
        end
        render :json => {message: "Success", comments: data}
    
    end

    def useropinioncomments
        comments = Comment.where("user_id = ? and opinion_id = ?", params[:user_id], params[:id])
        if comments.length > 0
            data = comments.map{|comment| {
                content: comment.content,
                user: comment.user.name,
                created_at: comment.created_at
            }}
        else
            data = []
        end
        render :json => {message: "Success", comments: data}
    end
end