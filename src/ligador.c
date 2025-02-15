#include "stdio.h"
#include "stdlib.h"

extern void alloc(
    int sz_file,
    int begin0, int sz0,
    int begin1, int sz1,
    int begin2, int sz2,
    int begin3, int sz3
);

int main(int argc, char *argv[]) {

    int sz_file = atoi(argv[1]);

    switch (argc - 2) {  
        case 0: alloc(atoi(argv[1]), -1,            -1,            -1,            -1,            -1,            -1,            -1,            -1);            break;
        case 2: alloc(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), -1,            -1,            -1,            -1,            -1,            -1);            break;
        case 4: alloc(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), -1,            -1,            -1,            -1);            break;
        case 6: alloc(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]), atoi(argv[7]), -1,            -1);            break;
        case 8: alloc(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]), atoi(argv[7]), atoi(argv[8]), atoi(argv[9])); break;
        default:
            printf("Too many arguments (expected up to 9)\n");
            return 1;
    }

    return 0;
}


