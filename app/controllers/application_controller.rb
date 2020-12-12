class ApplicationController < ActionController::API

    def issue_token(user)
        JWT.encode({user_id: user.id}, ENV['gitting_jiggy'], "HS256")
    end

    def current_user
        @user ||= User.find_by(id: user_id)
    end

    def token
        request.headers['Authorization']
    end

    def decoded_token
        begin
            JWT.decode(toke, ENV['gitting_jiggy'], true, { :algorithm => "HS256"})
        rescue JWT::DecodeError
            [{}]
        end
    end
    def user_id
        decoded_toke.first['user_id']
    end
    def logged_in?
        !!current_user
    end

    def authorized
        render json: { message: 'please sign up or log in'}, status: :authorized unless logged_in?
    end

end
