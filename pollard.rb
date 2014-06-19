require "mpi"

def Funkcja (a, rank, liczba)
  return a*a + rank % liczba 
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
  
  
  wynik = 0
  done = false
  world.Bcast(liczba.to_s,0)

    world.Recv(wynik.to_s, 0 , 0)
    print wynik
  

else


  liczba=liczba.to_i
  until done
    x = 2
    y = 2
    d = 1

    while d == 1 or d == -1
      x = Funkcja(x, rank, liczba.to_i)
      y = Funkcja(y, rank, liczba.to_i)
      y = Funkcja(y, rank, liczba.to_i)
      zmienna = x-y

      if zmienna <= 0
        zmienna = zmienna * -1   
      end
      d = GCD(zmienna, liczba)
      if d > 1 and d < liczba
        break
      end
      if d == liczba
        d = 0
        break
      end
    end
    if d != 0
      world.Send(d.to_s, 0, 0)
      done = true
    end
  end
end


MPI.Finalize
