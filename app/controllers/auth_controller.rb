class AuthController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if !user
            render json: {message: "No user by that name."}
        else
            # Now check Password
            if user.authenticate(params[:password])
                notes = Note.where(user: user)
                render json: { message: "Success", username: user.username, id: user.id, notes: notes}
            else
                render json: {message: "Invalid username and password"}
            end
        end
    end
end