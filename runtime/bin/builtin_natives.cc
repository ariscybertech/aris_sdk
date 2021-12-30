// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "include/dart_api.h"
#include "include/dart_tools_api.h"

#include "platform/assert.h"

#include "bin/builtin.h"
#include "bin/dartutils.h"
#include "bin/io_natives.h"
#include "bin/platform.h"

namespace dart {
namespace bin {

// Lists the native functions implementing basic functionality in
// standalone dart, such as printing, file I/O, and platform information.
// Advanced I/O classes like sockets and process management are implemented
// using functions listed in io_natives.cc.
#define BUILTIN_NATIVE_LIST(V)                                                 \
  V(Builtin_PrintString, 1)                                                    \
  V(Builtin_LoadSource, 4)                                                     \
  V(Builtin_AsyncLoadError, 3)                                                 \
  V(Builtin_DoneLoading, 0)                                                    \
  V(Builtin_NativeLibraryExtension, 0)                                         \
  V(Builtin_GetCurrentDirectory, 0)                                            \


BUILTIN_NATIVE_LIST(DECLARE_FUNCTION);

static struct NativeEntries {
  const char* name_;
  Dart_NativeFunction function_;
  int argument_count_;
} BuiltinEntries[] = {
  BUILTIN_NATIVE_LIST(REGISTER_FUNCTION)
};


/**
 * Looks up native functions in both libdart_builtin and libdart_io.
 */
Dart_NativeFunction Builtin::NativeLookup(Dart_Handle name,
                                          int argument_count,
                                          bool* auto_setup_scope) {
  const char* function_name = NULL;
  Dart_Handle result = Dart_StringToCString(name, &function_name);
  DART_CHECK_VALID(result);
  ASSERT(function_name != NULL);
  ASSERT(auto_setup_scope != NULL);
  *auto_setup_scope = true;
  int num_entries = sizeof(BuiltinEntries) / sizeof(struct NativeEntries);
  for (int i = 0; i < num_entries; i++) {
    struct NativeEntries* entry = &(BuiltinEntries[i]);
    if (!strcmp(function_name, entry->name_) &&
        (entry->argument_count_ == argument_count)) {
      return reinterpret_cast<Dart_NativeFunction>(entry->function_);
    }
  }
  return IONativeLookup(name, argument_count, auto_setup_scope);
}


const uint8_t* Builtin::NativeSymbol(Dart_NativeFunction nf) {
  int num_entries = sizeof(BuiltinEntries) / sizeof(struct NativeEntries);
  for (int i = 0; i < num_entries; i++) {
    struct NativeEntries* entry = &(BuiltinEntries[i]);
    if (reinterpret_cast<Dart_NativeFunction>(entry->function_) == nf) {
      return reinterpret_cast<const uint8_t*>(entry->name_);
    }
  }
  return IONativeSymbol(nf);
}


extern bool capture_stdout;


// Implementation of native functions which are used for some
// test/debug functionality in standalone dart mode.
void FUNCTION_NAME(Builtin_PrintString)(Dart_NativeArguments args) {
  intptr_t length = 0;
  uint8_t* chars = NULL;
  Dart_Handle str = Dart_GetNativeArgument(args, 0);
  Dart_Handle result = Dart_StringToUTF8(str, &chars, &length);
  if (Dart_IsError(result)) Dart_PropagateError(result);

  // Uses fwrite to support printing NUL bytes.
  fwrite(chars, 1, length, stdout);
  fputs("\n", stdout);
  fflush(stdout);
  if (capture_stdout) {
    // For now we report print output on the Stdout stream.
    uint8_t newline[] = { '\n' };
    Dart_ServiceSendDataEvent("Stdout", "WriteEvent", chars, length);
    Dart_ServiceSendDataEvent("Stdout", "WriteEvent",
                              newline, sizeof(newline));
  }
}

}  // namespace bin
}  // namespace dart