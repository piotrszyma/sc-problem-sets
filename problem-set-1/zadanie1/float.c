#include <stdio.h>
#include <float.h>

int main() {
  printf("Wartość float max (Float32):\n");
  printf("%.10e\n", FLT_MAX);
  printf("Wartość double max (Float64):\n");
  printf("%.10e\n", DBL_MAX);
  printf("Epsilon maszynowe (Float32):\n");
  printf("%.10e\n", FLT_EPSILON);
  printf("Epsilon maszynowe (Float64):\n");
  printf("%.10e\n", DBL_EPSILON);
}
