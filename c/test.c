#include <stdio.h>
#include <time.h>
#include <smi.h>

typedef    union {
        SmiUnsigned64       unsigned64;
        SmiInteger64        integer64;
        SmiUnsigned32       unsigned32;   
        SmiInteger32        integer32;
        SmiFloat32          float32;
        SmiFloat64          float64;
        SmiFloat128         float128;
        SmiSubid            *oid;
        char                *ptr;        /* OctetString, Bits                */
    } value;


int main() {
  printf("sizeof(SmiModule) = %lu\n", sizeof(SmiModule));
  printf("sizeof(SmiNode) = %lu\n", sizeof(SmiNode));
  printf("sizeof(SmiValue) = %lu\n", sizeof(SmiValue));  
  printf("sizeof(unsigned long long) = %lu\n", sizeof(unsigned long long));
  printf("sizeof(value) = %lu\n", sizeof(value));
  printf("sizeof(SmiBasetype) = %lu\n", sizeof(SmiBasetype));
  printf("sizeof(unsigned int) = %lu\n", sizeof(unsigned int));
  return 0;
}
        