class Number
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Fixnum

  field :p,     type: Fixnum
  field :q,     type: Fixnum

  field :np,      type: Fixnum
  field :number_of_tries, type: Fixnum
  field :console, type: String

  field :time, type: Array

  def factor
    time=Array.new
    fac=''
    number_of_tries.times do |j|
    tim=Array.new
      10.times do |i|
        t=Time.now
        cns=''
        status = POpen4::popen4( "mpirun -n #{i+2} a.out #{value}" ) do |stdout, stderr, stdin|  
          stdout.each do |line|  
            cns+= line.to_str
            break  
          end  
        end
        t1=Time.now
        tim << (t1-t)
        fac= cns.scan(/\d+/).first.to_i
      end
      time << tim
    end
    
  update_attribute(:console,fac)
  update_attribute(:p, fac)
  update_attribute(:q, value/fac)
  update_attribute(:time, time)
  end

end
