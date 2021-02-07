class PlantsController < ApplicationController

    get '/plants' do 
        redirect_if_not_logged_in
        @plants = Plant.all
        erb :'plants/index'
    end

    get '/plants/type/:id' do
        redirect_if_not_logged_in
        @type = Type.find(params[:id])
        erb :'/plants/type'
    end

    get '/plants/new' do
        redirect_if_not_logged_in
        @error_message = params[:error]
        erb :'/plants/new'
    end
    
    post '/plants' do
        if params[:plant][:variety] = "" || params[:plant][:description]="" || params[:plant][:type]=""
            redirect "/plants/new?error=variety, description and type can't be left blank"
        else
            if params[:type][:name] != ""
                @type = Type.create(params[:type])
                params[:plant][:type_id] = @type.id
            end
            @plant = Plant.create(params[:plant])
            current_user.plants << @plant
            redirect "/plants/#{@plant.id}"
        end
    end

    get '/plants/:id' do
        @error_message = params[:error]
        redirect_if_not_logged_in
        @plant = Plant.find(params[:id])
        erb :'/plants/show'
    end

    get '/plants/:id/edit' do
        redirect_if_not_logged_in
        @error_message = params[:error]
        @plant = Plant.find(params[:id])
        if @plant.user_id == current_user.id
            erb :'/plants/edit'
        else
            redirect "/plants/#{@plant.id}?error= You are not allowed to edit or delete other user's plant."
        end
    end

    patch '/plants/:id' do 
        @plant = Plant.find(params[:id])
        if params[:type][:name] != ""
            @type = Type.create(params[:type])
            params[:plant][:type_id] = @type.id
        end
        @plant.update(params[:plant])
        redirect "/plants/#{@plant.id}"
    end
    
    delete '/plants/:id' do
        redirect_if_not_logged_in
        @plant = Plant.find(params[:id])
        if @plant.user_id == current_user.id
            @plant.delete
            redirect "/users/#{current_user.slug}"
        else
            redirect "/plants/#{@plant.id}?error= You are not allowed to edit or delete other user's plant."
        end
    end


end