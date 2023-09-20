#include <stdio.h>
#include <stdlib.h>

int anotherFunc(void)
{
  // todo: findout why if there's no malloc the program throw segfault? asumsi sementara: karena prepare pemanggilan fungsi yang menyebabkan value dari test terisi (?)
  char *test = (char *)malloc(5);
  if (!fgets(test, 5, stdin)) {
    printf("wowow");
  }
  printf(test);

  return 0;
}

int main(void)
{
  anotherFunc();
  printf("Hewwooo");
}

// investigate why UB not showed up in this way
// int main(void) {
//   char *test;
//   fgets(test, 5, stdin);
//   printf(test);
// }

struct Person {
  char name[64];
  int age;
};

int playWithPointer(void) {
  struct Person people[100];
  struct Person *p_Person = &people;

  for (int i = 0; i < 100; i++)
  {
    (p_Person + i)->age = i;
    // p_Person += 1;
    printf("i: %d | age: %d\n", i, (p_Person + i)->age);  
  }

}