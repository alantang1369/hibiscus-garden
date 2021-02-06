class UsersController < ApplicationController
    
    get '/users/:slug' do 
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            if !!@user
                erb :'/users/show' 
            else
                redirect "/?error=No user found!"
            end
        else
            redirect_if_not_logged_in
        end
    end

    get '/signup' do
        @error_message = params[:error]
        if !logged_in?
            erb :'/users/signup'
        else
            @user = current_user
            redirect "/users/#{@user.slug}"
        end

    end

    post '/signup' do 
        if params[:username] == "" || params[:password] == "" 
            redirect to '/signup?error=invalid username'
        else
            @user = User.create(params)
          
            if !@user.errors.any?
                session[:user_id] = @user.id
                redirect "/users/#{@user.slug}"
            else
                redirect "/signup?error=This username was already taken."
            end
        end
    end

    get '/login' do
        @error_message = params[:error]
        if logged_in?
            @user = current_user
            redirect "/users/#{@user.slug}"
        else
            erb :'/users/login'
        end

    end
    
    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.slug}"
        else
            redirect "/login?error=Invalid username or password."
        end
    end



    get '/logout' do 
        redirect_if_not_logged_in
        session.destroy
        redirect "/"
    end



end
