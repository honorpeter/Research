/*
 * =====================================================================================
 *
 *       Filename:  benchmark.c
 *
 *    Description:  Benchmark implementation
 *
 *        Version:  1.0
 *        Created:  09/02/2014 07:34:38 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include "benchmark.h"
#include <stdint.h>
#include <stdio.h>

void calcOffset(Benchmark *pB);


/*-----------------------------------------------------------------------------
 *  Function: initBenchmark
 *  Parameters: Benchmark*  - Benchmark to be initialized
 *
 *  Description:
 *    Initializes the benchmark to default values.
 *-----------------------------------------------------------------------------*/
void initBenchmark(Benchmark *pB, const char *name, const char *desc)
{
  pB->name = name;
  pB->descript = desc;
  pB->t_start.tv_sec = 0;
  pB->t_start.tv_nsec = 0;
  pB->t_stop.tv_sec = 0;
  pB->t_stop.tv_nsec = 0;

  calcOffset(pB);
}


/*-----------------------------------------------------------------------------
 *  Function: startBenchmark
 *
 *  Description:
 *    Records the time at which the benchmark begins.
 *-----------------------------------------------------------------------------*/
void startBenchmark(Benchmark *pB)
{
  clock_gettime(CLOCK_REALTIME,&pB->t_start);
}
/*-----------------------------------------------------------------------------
 *  Function: stopBenchmark
 *
 *  Description:
 *    Records the time at which the benchmark begins.
 *-----------------------------------------------------------------------------*/
void stopBenchmark(Benchmark *pB)
{
  clock_gettime(CLOCK_REALTIME,&pB->t_stop);
}

/*-----------------------------------------------------------------------------
 *  Function: printBenchmark
 *
 *  Description:
 *    Prints the duration between stop and start minus the offset value
 *-----------------------------------------------------------------------------*/
void printBenchmark(Benchmark *pB)
{
  struct timespec t_temp;
  double secs;
  t_temp.tv_sec = pB->t_stop.tv_sec - pB->t_start.tv_sec - pB->t_offset.tv_sec;
  t_temp.tv_nsec = pB->t_stop.tv_nsec - pB->t_start.tv_nsec - pB->t_offset.tv_nsec;

  secs = (double)t_temp.tv_sec + (double)t_temp.tv_nsec * (double)1E-9;

  fprintf(stdout, "%s = %f\n", pB->name, secs);
  fprintf(stdout, "sec = %ju, nsec = %ld\n", (uintmax_t)t_temp.tv_sec, t_temp.tv_nsec);

}

/*-----------------------------------------------------------------------------
 *  Function: calcOffset
 *  Parameters: Benchmark*  - Benchmark to calculate the offset for
 *
 *  Description:
 *    Calculates the time it takes to call the start and stop so it can be
 *    subtracted later.
 *-----------------------------------------------------------------------------*/
void calcOffset(Benchmark *pB)
{
  startBenchmark(pB);
  stopBenchmark(pB);
  pB->t_offset.tv_sec = pB->t_stop.tv_sec - pB->t_start.tv_sec;
  pB->t_offset.tv_nsec = pB->t_stop.tv_nsec - pB->t_start.tv_nsec;
}
