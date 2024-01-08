#include <stdbool.h>
#include <string.h>
#include <stdio.h>

bool solution(const char *string, const char *ending)
{
  int i;
  int j;
  bool match = false;
  
  if (ending[0] == '\0') return true;
  
  i = strlen(ending) - 1;
  j = strlen(string) - 1;

  if (i > j) return false;

  for (; j >= 0; j--) {
    if (string[j] == ending[i]) match = true;
    else {
     match = false;
     break;
    }
    if (i == 0)
      break;

    i--;
  }
 
  return match;
}

int main(void)
{
	printf("%d\n", solution("satu", "tu"));
	printf("%d\n", solution("hello", "llo"));
	printf("%d\n", solution("abc", "bc"));
	printf("%d\n", solution("abc", "d"));
	printf("%d\n", solution("abc", ""));

	return 0;
}

