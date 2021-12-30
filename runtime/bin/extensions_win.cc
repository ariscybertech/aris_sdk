// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "platform/globals.h"
#if defined(TARGET_OS_WINDOWS)

#include "bin/extensions.h"
#include "bin/utils.h"
#include "bin/utils_win.h"


namespace dart {
namespace bin {

const char* kPrecompiledLibraryName = "precompiled.dll";
const char* kPrecompiledSymbolName = "_kInstructionsSnapshot";

void* Extensions::LoadExtensionLibrary(const char* library_file) {
  return LoadLibraryW(StringUtilsWin::Utf8ToWide(library_file));
}

void* Extensions::ResolveSymbol(void* lib_handle, const char* symbol) {
  return GetProcAddress(reinterpret_cast<HMODULE>(lib_handle), symbol);
}

}  // namespace bin
}  // namespace dart

#endif  // defined(TARGET_OS_WINDOWS)
