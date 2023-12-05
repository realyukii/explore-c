#include <linux/module.h>
#include <linux/kernel.h>

/*
* https://www.youtube.com/watch?v=SOo1rbnryeo
*
* on WSL, you need extra effort to make it works
* 1. leave the default kernel, compile it and use the compiled version as mentioned in the link below
* https://unix.stackexchange.com/questions/594470/wsl-2-does-not-have-lib-modules
* 2. make sure the  Linux headers already installed as mentioned in the link above
*
* tips n trick, resource and documentation:
* - https://devhints.io/makefile
* - required dependency: <WSL2-Linux-kernel>/Documentation/process/changest.rst
* - you can always find these keyword: `-C`
* on `man make`
* - you can always find these keyword: `obj-m`, `M=dir`
* on https://github.com/microsoft/WSL2-Linux-Kernel/blob/linux-msft-wsl-5.15.y/Makefile
*/

int init_module(void)
{
	printk(KERN_INFO "Cats module loaded!\n");
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Cats module unloaded!\n");
}