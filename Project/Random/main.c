#include "Foundation.h"

int main(int argc, const char * argv[])
{
    for (int i = 0; i < 10; i++)
    {
        printf("Random value = %d\r\n", RandomWithRange(-3, 5));
    }
}