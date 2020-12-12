class AuthController < ApplicationController
    def create
        # byebug
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
            payload = { user_id: user.id }

            token = JWT.encode(payload, 'gitting_jiggy', 'HS256')

            render json: { user: {id: user.id, name: user.name, }, token: token }
        else
            render json: { error: 'Invalid username/password.' }, status: 401
        end
    end

    def show
        token = request.headers[:Authorization].split(' ')[1]
        decoded_token = JWT.decode(token, 'gitting_jiggy', true, { algorithm: 'HS256'})
        user_id = decoded_token[0]['user_id']
        user = User.find(user_id)
        render json: {user: {id: user.id, name: user.name}}
    end
end