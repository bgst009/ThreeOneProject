//
// Created by bgst on 2020/8/27.
//

#include <stdio.h>
#include <stdlib.h>
#include <w32api/synchapi.h>

int main() {

    int x = 1, y = 1;
    int v_x = 1, v_y = 1;
    int top = 0;
    int bottom = 20;
    int left = 0;
    int right = 25;

    while (1) {

        system("clear");

        x += v_x;
        y += v_y;


        for (int i = 0; i < x; i++) {
            printf("\n");
        }
        for (int i = 0; i < y; i++) {
            printf(" ");
        }
        printf("O");
        printf("\n");

        if ((x == top) || x == bottom) {
            v_x = -1 * v_x;
            printf("\a");
        }
        if ((y==left)||(y==right)){
            v_y = -1 * v_y;
            printf("\a");
        }

        Sleep(50);

//        for (int i = 0; i < 10000; ++i) {
//            for (int j = 0; j < 10000; ++j) {
//
//            }
//        }
    }

    return 0;
}