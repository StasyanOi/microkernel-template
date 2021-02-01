#include "screen.h"
#include "util.h"
#include "isr.h"
#include "timer.h"
#include "keyboard.h"

//vga 80 columns * 25 lines  
void main() {
  kprint("Hello world");
}
