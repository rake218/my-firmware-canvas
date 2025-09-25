#include "greetings.h"
#include <stdio.h>
#include <string.h>

void greet(char *buf, size_t n) {
    if (!buf || n == 0) return;
    snprintf(buf, n, "Hello, Embedded World!");
}

void greet_person(const char *name, char *buf, size_t n) {
    if (!buf || n == 0) return;
    if (!name || name[0] == '\0') {
        snprintf(buf, n, "Hello, Guest!");
    } else {
        snprintf(buf, n, "Hello, %s!", name);
    }
}
/* end of file*/
