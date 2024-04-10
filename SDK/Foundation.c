#include <stdlib.h>

int RandomWithRange(int fromNumber, int toNumer)
{
    int minNumber = fromNumber < toNumer ? fromNumber : toNumer;
    int maxNumber = fromNumber > toNumer ? fromNumber : toNumer;
    return rand() % (maxNumber - minNumber + 1) + minNumber;;
}