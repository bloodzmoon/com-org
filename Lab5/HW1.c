

#include <stdio.h>
#include <stdlib.h>

int hw1(void)
{
    FILE * fp;
    int c;

    fp = fopen ("Makefile", "r");

    while(1) {
      c = fgetc(fp);
      if( feof(fp) ) {
         break;
      }
      printf("%c \t %d \t %x\n", c, c, c);
    }

    fclose(fp);

    return 0;
}
