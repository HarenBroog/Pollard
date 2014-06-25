require "mpi"


def Funkcja (a, rank, liczba)
  return (a*a + rank) % liczba 
end

def GCD (a, b)
  while b > 0
    t = a
    a = b
    b = t % b
  end
  if a < 0
    return a * -1
  else
    return a
  end
end

MPI.Init
world = MPI::Comm::WORLD

if world.size == 1
  print "Size is one, so do nothing\n"
  exit
end

rank = world.rank
liczba = ARGV[0]

if rank == 0
  
  
  # world.Bcast(liczba.to_s,0)

  
    
    str ="\x00"*100
    msg=""
    i=1
    while msg==""
        world.Recv(str,i,0)
        msg=str.gsub(/\000/,"")
        i>=world.size-1 ? i=1 : i+=1 
    end
    p msg
    


else


    l=liczba.to_i
    cx=rank
    cy=rank

    x = 2
    y = 2
    d = 1
    

    while d == 1 or d == -1

      x = Funkcja(x, cx, l)
      y = Funkcja(y, cy, l)
      y = Funkcja(y, cy, l)
      
      zmienna = x-y

      if zmienna <= 0
        zmienna = zmienna * -1   
      end

      d = GCD(zmienna, l)

      if d > 1 and d < l
        break
      end

      if d == l
        d = 0
        cx-=1
        cy-=1
        break
      end

    end

    if d != 0
      message = "#{d}"
      world.Send(message, 0, 0)
      done = true
    end



end

MPI.Finalize
exit

