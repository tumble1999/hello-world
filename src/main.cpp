#include <iostream>

#ifdef NDS
#include <nds.h>
#include <nf_lib.h>
#endif // !NDS

void begin() {
#ifdef NDS
  consoleDemoInit();
  consoleClear();
  setBrightness(3, 0);
#endif // NDS
}

void finish() {
#ifdef NDS
  while (1) {
    swiWaitForVBlank(); // Wait for vertical Blank
  }
#endif // NDS
}

int main() {
  begin();
  std::cout << "Hello World!\n";
  finish();
  return 0;
}