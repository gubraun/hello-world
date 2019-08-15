#include <stdio.h>

int main()
{
	char *crashme = NULL;
	printf("Hello World\n");
	*crashme = 0;
	return 0;
}
