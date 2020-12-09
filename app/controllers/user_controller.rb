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
        user = User.find_by(id: params[:id])
        if user
            data = {message: "Success", :user => {name: user[:name], email: user[:email]}}
            render :json => data
        else
            data = {message: "Could not access user"}
            render :json => data
        end
    end

    def update
    end

    def delete
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :profile_picture)
        end
end
