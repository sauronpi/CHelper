#include "Foundation.h"

int main(int argc, const char *argv[]) {
    void *point = NULL;
    printf("short int size\t%lu byte\n", sizeof(short int));
    printf("int size\t%lu byte\n", sizeof(int));
    printf("long int size\t%lu byte\n", sizeof(long int));
    printf("long long size\t%lu byte\n", sizeof(long long));
    printf("float\t\t%lu byte\n", sizeof(float));
    printf("double\t\t%lu byte\n", sizeof(double));
    printf("bool size\t%lu byte\n", sizeof(bool));
    printf("char size\t%lu byte\n", sizeof(char));
    printf("void point\t%lu byte\n", sizeof(point));
}
