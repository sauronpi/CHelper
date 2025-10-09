#include "Foundation.h"

int main(int argc, const char *argv[]) {
    void *point = NULL;
    printf("short int size %lu byte\n", sizeof(short int));
    printf("int size %lu byte\n", sizeof(int));
    printf("long int size %lu byte\n", sizeof(long int));
    printf("long long size %lu byte\n", sizeof(long long));
    printf("float %lu byte\n", sizeof(float));
    printf("double %lu byte\n", sizeof(double));
    printf("bool size %lu byte\n", sizeof(bool));
    printf("char size %lu byte\n", sizeof(char));
    printf("void point %lu byte\n", sizeof(point));
}
