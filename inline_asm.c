void _start(void)
{
	asm("call main");
	asm("mov edi, eax");
	asm("mov eax, 60");
	asm("syscall");
}

int main(void)
{
	return 9;
}

