
#include <stdio.h>

int fib(int);

int hw2() {

    int n = 0;
    printf("Enter number of Fibonacci : ");
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        printf("%d ", fib(i));
    }

    return 0;
}

int fib(int a) {
    if (a <= 2)
        return 1;
    else
        return fib(a-1) + fib(a-2);
}
