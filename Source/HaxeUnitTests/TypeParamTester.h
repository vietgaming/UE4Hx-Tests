#pragma once

#include "Engine.h"
#include <TypeParamGlue.h>
#include <cstdio>
//

#define TEST_ROUNDTRIP(type,obj) \
  printf("Testing " #type" (" #obj")\n"); \
  if (TypeParamGlue<type>::haxeToUe(TypeParamGlue<type>::ueToHaxe(obj)) != obj) { \
    fprintf(stderr, "ERROR roundtrip on "#type" for "#obj"\n"); \
    return false; \
  }

class HAXEUNITTESTS_API FTypeParamTester {
public:
  static bool testRoundtrip() {
    TEST_ROUNDTRIP(bool, true);
    TEST_ROUNDTRIP(bool, false);
    TEST_ROUNDTRIP(int32, 42);
    TEST_ROUNDTRIP(uint32, 0xFFFFFFFF);
    TEST_ROUNDTRIP(int8, (int8) -1);
    TEST_ROUNDTRIP(uint8, 0xFF);
    TEST_ROUNDTRIP(int16, (int16) -1);
    TEST_ROUNDTRIP(uint16, 0xFFFF);
    TEST_ROUNDTRIP(int32, (int32) -1);
    TEST_ROUNDTRIP(uint32, 0xFFFFFFFF);
    TEST_ROUNDTRIP(int64, (int64) -1LL);
    TEST_ROUNDTRIP(uint64, 0xFFFFFFFFFFFFFFFFULL);

    return true;
  }
};