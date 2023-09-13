#include <stddef.h>
#include <stdint.h>

uint64_t joinStringsSize(const char* firstname, const char* lastname);
uint64_t joinStrings(uint8_t* buf_ptr, size_t buf_len, const char* firstname, const char* lastname);
