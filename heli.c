#include <mpi.h>
#include <time.h>
#include <stdlib.h>


long Funkcja(long a, long rank, long liczba, int r)
{
	return (a * a + r + rank) % liczba; 
}

long GCD(long a, long b)
{
while(b != 0)
{
	long t = a;
	a = b;
	b = t % b;	
}
if(a < 0)
	{
		return a * -1;

	}else
	{
		return a;
	}
}

int main(int argc, char** argv) {
srand(time(NULL));
int r = rand() % 100;
  MPI_Init(NULL, NULL);
  int world_size;
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);
  long liczba = 0;
  long wynik = 0;
  int world_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);
/*if (world_rank == 0)
	{
		printf("Proszę podać pierwszą liczbę: \n");
		scanf ("%d",&liczba);                    
   		if(liczba == 0)
		{
		printf("Błąd\n");
		  MPI_Finalize();
return 0;
		}
	}*/
	liczba = atol(argv[1]);
	MPI_Barrier(MPI_COMM_WORLD);
	MPI_Bcast(&liczba, 1, MPI_LONG, 0, MPI_COMM_WORLD);
	
	if (world_rank != 0)
        {
            short done = 0;
            while (done != 1)
            {
                long x = 2;
                long y = 2;
                long d = 1;
                while (d == 1 || d == -1)
                {
                    x = Funkcja(x, world_rank, liczba, r);
                    y = Funkcja(y, world_rank, liczba, r);
                    y = Funkcja(y, world_rank, liczba, r);
                    long zmienna = x - y;
                    if (zmienna < 0)
                    {
                        zmienna = zmienna*-1;
                    }
                    d = GCD(zmienna, liczba);
                    if (d > 1 && d < liczba)
                    {
                        break;
                    }
                    if (d == liczba)
                    {
                        d = 0;
                        break;
                    }
                }
                if (d > 0)
                {
		MPI_Send(&d, 1, MPI_LONG, 0, 0, MPI_COMM_WORLD);
                    done = 1;
                }else
		{
			r = rand() % 100;
		}
            }
        }
        else
        {
      	    MPI_Recv(&wynik, 1, MPI_LONG, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
            printf("Wynik to: %ld\n", wynik);
      	    MPI_Abort(MPI_COMM_WORLD, 2);
      	    MPI_Finalize();
      		return wynik;
        }
  MPI_Finalize();
}
