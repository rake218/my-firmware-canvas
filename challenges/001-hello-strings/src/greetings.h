#ifndef GREETINGS_H
#define GREETINGS_H

#include <stddef.h>

/* Fill buf (size n) with a greeting message. */
void greet(char *buf, size_t n);

/* Fill buf (size n) with a personalized greeting for name.
   If name is NULL or empty, use a default. */
void greet_person(const char *name, char *buf, size_t n);

#endif /* GREETINGS_H */
