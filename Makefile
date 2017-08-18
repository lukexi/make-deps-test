SOURCES := $(wildcard src/*.c)
OBJECTS := $(SOURCES:src/%.c=build/%.o)
DEPENDS := $(SOURCES:src/%.c=build/%.d)

all: build/ main

-include $(DEPENDS)

build/:
	mkdir -p build

build/%.o: src/%.c
	clang -MMD -c -o $@ $< -Isrc

main: main.c $(OBJECTS)
	clang -o $@ $^ -Isrc

clean:
	rm -rf build/
	rm -f src/*.o src/*.d main
