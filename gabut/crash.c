int main(void)
{
	// invalid address
	int *a = 0;
	// SEGFAULT, NULL pointer dereference XD
	*a = 5;
	return 0;
}
