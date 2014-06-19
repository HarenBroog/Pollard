require 'rubygems'
require 'popen4'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  expose(:number)

  def home
    
  @text=""
   status = POpen4::popen4('mpirun -np 4 ruby hello.rb') do |stdout, stderr, stdin|  
    stdout.each do |line|  
      @text+= line.to_str  
      end  
    end
  
  end

end
