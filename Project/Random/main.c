#include "Foundation.h"
#include <stdlib.h>
#include <time.h>

int main(int argc, const char *argv[]) {
    srand(time(NULL)); // 使用当前时间作为种子
    for (int i = 0; i < 10; i++) {
        printf("Random value = %d\r\n", RandomWithRange(-3, 5));
    }
}
