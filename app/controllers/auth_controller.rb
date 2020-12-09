class AuthController < ApplicationController
    def create
        # byebug
        user = User.find_by(name: params[:name])
        if !user
            render json: {message: "No user by that name."}
        else
            # Now check Password
            if user.authenticate(params[:password])
                render json: { message: "Success", user: user}
            else
                render json: {message: "Invalid username and password"}
            end
        end
    end
end