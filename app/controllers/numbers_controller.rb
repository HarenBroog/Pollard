require 'rubygems'
require 'popen4'

class NumbersController < ApplicationController

expose(:number, attributes: :number_params)

def create
  if number.save
    number.factor
    redirect_to number_path(number)
  else
    redirect_to :new
  end
end

def new
end

def show
end


private

def number_params
  params.require(:number).permit(:value, :np, :number_of_tries)
end

end
