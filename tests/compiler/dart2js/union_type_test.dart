// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:async_helper/async_helper.dart";
import "package:expect/expect.dart";
import "package:compiler/src/types/types.dart";

import "compiler_helper.dart";

main() {
  MockCompiler compiler = new MockCompiler.internal(analyzeOnly: true);
  asyncTest(() => compiler.runCompiler(null, """
      main() {
        print(2); print("Hello");
      }
    """).then((_) {
    FlatTypeMask mask1 =
        new FlatTypeMask.exact(compiler.intClass);
    FlatTypeMask mask2 =
        new FlatTypeMask.exact(compiler.stringClass);
    UnionTypeMask union1 = mask1.nonNullable().union(mask2, compiler.world);
    UnionTypeMask union2 = mask2.nonNullable().union(mask1, compiler.world);
    Expect.equals(union1, union2);
  }));
}
