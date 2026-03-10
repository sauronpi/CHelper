#include <Foundation.h>

int main(int argc, const char *argv[]) {
    void *point = NULL;
    printf("short int size\t%llu byte\n", sizeof(short int));
    printf("int size\t%llu byte\n", sizeof(int));
    printf("long int size\t%llu byte\n", sizeof(long int));
    printf("long long size\t%llu byte\n", sizeof(long long));
    printf("float\t\t%llu byte\n", sizeof(float));
    printf("double\t\t%llu byte\n", sizeof(double));
    printf("bool size\t%llu byte\n", sizeof(bool));
    printf("char size\t%llu byte\n", sizeof(char));
    printf("void point\t%llu byte\n", sizeof(point));
}
