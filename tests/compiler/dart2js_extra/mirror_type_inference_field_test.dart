// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Test that type inference sees the possible modification of `fisk` from
// the mirror system and not infers the value to be an integer.
library test;

@MirrorsUsed(targets: 'fisk', override: '*')
import 'dart:mirrors';

import 'package:expect/expect.dart';

var fisk = 1;

main() {
  var lm = currentMirrorSystem().findLibrary(const Symbol('test'));
  lm.setField(const Symbol('fisk'), 'hest');
  Expect.isTrue(fisk is String);
}
