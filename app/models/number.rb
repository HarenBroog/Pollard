class Number
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Fixnum

  field :p,     type: Fixnum
  field :q,     type: Fixnum

  field :np,      type: Fixnum
  field :number_of_tries, type: Fixnum
  field :console, type: String

  def factor
    console=''
    status = POpen4::popen4( "mpirun -np #{np} ruby pollard.rb" ) do |stdout, stderr, stdin|  
    stdout.each do |line|  
      console+= line.to_str  
      end  
    end  
  end

end
