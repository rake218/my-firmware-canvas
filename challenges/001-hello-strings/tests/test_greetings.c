#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "greetings.h"

int main(void) {
    char buf[128];

    greet(buf, sizeof(buf));
    assert(strcmp(buf, "Hello, Embedded World!") == 0);

    greet_person("Alice", buf, sizeof(buf));
    assert(strcmp(buf, "Hello, Alice!") == 0);

    greet_person("", buf, sizeof(buf));
    assert(strcmp(buf, "Hello, Guest!") == 0);

    printf("All greeting tests passed\n");
    return 0;
}
