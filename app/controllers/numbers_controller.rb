class NumbersController < ApplicationController

expose(:number)

def show
  number = POpen4::popen4( 'mpirun hello.rb' ) do |stdout, stderr, stdin|     
 end  
end

end
