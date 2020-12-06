require 'pry'

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if params['pet'].empty?
      redirect '/pets/new'
    end
    @pet = Pet.create(params['pet'])
    @pet.owner = Owner.create(name: params[:owner_name]) if !params[:owner_name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.owner = Owner.create(name: params[:owner][:name]) if !params[:owner][:name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end