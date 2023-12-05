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
*
* summary:
* so the essential thing is use the custom kernel by update .wslconfig on %userprofile% as mentioned on unix.stackexchange.com
* and then compiling as usual as instructed in https://tldp.org/LDP/lkmpg/2.6/html/x181.html
* the last one to do is load it with insmod
* and see the kernel log for your module with dmesg ^^
* optional, you can see the detail with modinfo, as mentioned in the tldp.org site
* 
* it turns out, I just only need root privilege on insmod command O_o
*
* also, wondering why the youtube video not require MODULE_LICENSE,
* while my mine will error if it isn't include in the .c file
* and wondering why generating so many files?
*
* wondering output from dmesg: loading out-of-tree module taints kernel.
*/

MODULE_LICENSE("GPL");

int init_module(void)
{
	printk(KERN_INFO "Cats module loaded!\n");
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Cats module unloaded!\n");
}