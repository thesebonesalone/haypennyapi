class UserController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            data = {user: user, message: "Success"}
            render :json => data
        else
            data = {message: "Could not create user"}
            render :json => data
        end
    end

    def show
        user = User.find_by(name: params[:id])
        if user

            opinions = user.opinions.map{|opinion|
                    {reactions: opinion.reactions.map{|reaction| reaction.kind},
                    user: opinion.user.name,
                    topic: opinion.topic.title,
                    created_at: opinion.created_at,
                    content: opinion.content,
                    id: opinion.id,
                    positivity: opinion.positivity,
                    weird: opinion.weird}
            }
            data = {message: "Success", :user => {name: user[:name], email: user[:email], id: user.id, profile_picture: user.profile_picture, opinions: opinions}}
            
            render :json => data
        else
            data = {message: "Could not access user"}
            render :json => data
        end
    end

    def update
        user = User.update(user_params)
        if user
            data = {message: "Success", :user => {name: user[:name], email: user[:email], id: user.id, profile_picture: user.profile_picture}}
        else
            data = {message: "Could not update user"}
        end
        render :json => data
    end

    def delete
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :profile_picture)
        end
end
