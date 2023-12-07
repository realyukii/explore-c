#include <unistd.h>
#include <signal.h>

/*
* try compile with -ggdb3
* gef> r
* gef> finish # press enter until escaping from the raise entry
* gef> i locals # interpreted data
* gef> p/x var # raw hex format data
* so, the conclusion is that the stdin treat the input as ascii format,
* even if you pass the integer to the stdin
* https://t.me/c/1987506309/1120/1287
*/
int main(void)
{
	char var[1];
	read(1, var, 1);
	raise(SIGTRAP);
	return 0;
}