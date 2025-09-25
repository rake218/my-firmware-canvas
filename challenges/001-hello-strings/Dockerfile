FROM ubuntu:22.04
RUN apt-get update && apt-get install -y build-essential
WORKDIR /workspace
COPY src/ src/
COPY tests/ tests/
RUN gcc -Wall -Werror -O2 -std=c99 -I src src/greetings.c tests/test_greetings.c -o /workspace/test_greetings
CMD ["/workspace/test_greetings"]
