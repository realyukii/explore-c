#include <windows.h>

#define SIZE_BUF 255

DWORD WINAPI input(LPVOID param) {
        HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);
        HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
        DWORD legible;
        while (TRUE) {
                WriteConsole(hStdout, "> ", 3, NULL, NULL);
                char buff[SIZE_BUF];
                ReadConsole(hStdin, &buff, SIZE_BUF, &legible, NULL);
        }

        return 0;
}
int main(void)
{
        CreateThread(NULL, 0, input, NULL, 0, NULL);
        MessageBox(NULL, "Hello world!", "Hello Program", MB_OK | MB_ICONINFORMATION);
        return 0;
}
