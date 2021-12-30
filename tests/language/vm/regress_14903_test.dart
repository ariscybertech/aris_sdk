// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// VMOptions=--optimization-counter-threshold=10 

import "package:expect/expect.dart";

// Test identical comparisons in optimized code. Registers must be preserved
// when calling the runtime.

cmp(a, b, c) {
  var v = c + 1;
  var w = v + 1;
  var x = w + 1;
  var y = x + 1;
  var z = y + 1;
  if (identical(a, b)) {
    c++;
  }
  return c + v + w + x + y + z;
}


main() {
  var big = 100000000000000000000000000000000000;
  var before = cmp(big, big, 0);
  Expect.equals(16, before);
  for (var i = 0; i < 20; i++) cmp(big, big + 1, 0);
  Expect.equals(before, cmp(big, big, 0));
}

