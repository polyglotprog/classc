#include <stdbool.h>

class Object {
  int hash(void* this);
  bool equals(void* this, void* that);
  char* to_string(void* this);
}
