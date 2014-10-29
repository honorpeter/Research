/*
 * =====================================================================================
 *
 *       Filename:  benchmark.h
 *
 *    Description:  Benchmark header
 *
 *        Version:  1.0
 *        Created:  09/02/2014 07:25:03 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifndef _BENCHMARK_H_
#define _BENCHMARK_H_

#include <time.h>

typedef struct{
  const char *name;
  const char *descript;

  struct timespec t_start;
  struct timespec t_stop;

  struct timespec t_offset;
}Benchmark;

void initBenchmark(Benchmark*,const char*,const char*);      /* Initializes the Benchmark */
void startBenchmark(Benchmark*);                 /* Starts the benchmark timer */
void stopBenchmark(Benchmark*);                  /* Stops the benchmark timer */
void printBenchmark(Benchmark*);             /* Prints the duration in seconds */
void csvBenchmark(Benchmark*,char*);         /* Writes the duration to file as csv */

#endif // !_BENCHMARK_H_

