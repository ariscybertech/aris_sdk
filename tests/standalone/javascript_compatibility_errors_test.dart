// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// VMOptions=--warn_on_javascript_compatibility --warning_as_error --optimization_counter_threshold=5

import "package:expect/expect.dart";

f(x, y) {
  // Unoptimized and optimized code.
  1 is double;  /// 00: ok
  if (1 is double) { x++; }  /// 01: ok
  try { 1 as double; } on CastError catch (e) { }  /// 02: ok
  try { var y = 1 as double; } on CastError catch (e) { }  /// 03: ok
  1.0 is int;  /// 04: ok
  if (1.0 is int) { x++; }  /// 05: ok
  try { 1.0 as int; } on CastError catch (e) { }  /// 06: ok
  try { var z = 1.0 as int; } on CastError catch (e) { }  /// 07: ok

  x is double;  /// 10: ok
  if (x is double) { }  /// 11: ok
  try { x as double; } on CastError catch (e) { }  /// 12: ok
  try { var z = x as double; } on CastError catch (e) { }  /// 13: ok
  y is int;  /// 14: ok
  if (y is int) { }  /// 15: ok
  try { y as int; } on CastError catch (e) { }  /// 16: ok
  try { var z = y as int; } on CastError catch (e) { }  /// 17: ok

  // It is a compile-time error if evaluation of a constant object results in
  // an uncaught exception being thrown, a JavascriptCompatibilityError here.
  "${1.0}";  /// 20: compile-time error
  var z = "${1.0}";  /// 21: compile-time error

  (1.0).toString();  /// 22: ok
  var z = (1.0).toString();  /// 23: ok
  "$y";  /// 24: ok
  var z = "$y";  /// 25: ok
  y.toString();  /// 26: ok
  var z = y.toString();  /// 27: ok

  var a = "yz";
  var b = "xyz";
  b = b.substring(1);
  if (identical(a, b)) { }  /// 28: ok

  if (identical(x, y)) { }  /// 29: ok
  if (identical(y, x)) { }  /// 30: ok

  if (x > 10) {
    // Optimized code.
    x is double;  /// 40: ok
    if (x is double) { }  /// 41: ok
    try { x as double; } on CastError catch (e) { }  /// 42: ok
    try { var z = x as double; } on CastError catch (e) { }  /// 43: ok
    y is int;  /// 44: ok
    if (y is int) { }  /// 45: ok
    try { y as int; } on CastError catch (e) { }  /// 46: ok
    try { var z = y as int; } on CastError catch (e) { }  /// 47: ok

    "${1.0}";  /// 50: compile-time error
    var z = "${1.0}";  /// 51: compile-time error

    (1.0).toString();  /// 52: ok
    var z = (1.0).toString();  /// 53: ok
    "$y";  /// 54: ok
    var z = "$y";  /// 55: ok
    y.toString();  /// 56: ok
    var z = y.toString();  /// 57: ok

    var a = "yz";
    var b = "xyz";
    b = b.substring(1);
    if (identical(a, b)) { }  /// 58: ok

    if (identical(x, y)) { }  /// 59: ok
    if (identical(y, x)) { }  /// 60: ok
  }
}

k(x, y) {
  // Unoptimized and optimized code.
  1.5 is double;
  if (1.5 is double) { x++; }
  try { 1.5 as double; } on CastError catch (e) { }
  try { var y = 1.5 as double; } on CastError catch (e) { }
  1.5 is int;
  if (1.5 is int) { x++; }
  try { 1.5 as int; } on CastError catch (e) { }
  try { var z = 1.5 as int; } on CastError catch (e) { }

  1.5 is double;
  if (1.5 is double) { x++; }
  try { 1.5 as double; } on CastError catch (e) { }
  try { var y = 1.5 as double; } on CastError catch (e) { }
  1.5 is int;
  if (1.5 is int) { x++; }
  try { 1.5 as int; } on CastError catch (e) { }
  try { var z = 1.5 as int; } on CastError catch (e) { }

  x is double;
  if (x is double) { }
  try { x as double; } on CastError catch (e) { }
  try { var z = x as double; } on CastError catch (e) { }
  y is int;
  if (y is int) { }
  try { y as int; } on CastError catch (e) { }
  try { var z = y as int; } on CastError catch (e) { }

  "${1.5}";
  var z = "${1.5}";
  (1.5).toString();
  z = (1.5).toString();
  "$y";
  z = "$y";
  y.toString();
  z = y.toString();

  var a = "xyz";
  var b = "xyz";
  b = b.substring(1);
  if (identical(a, b)) { }

  if (identical(x, y)) { }
  if (identical(y, x)) { }

  if (x > 10) {
    // Optimized code.
    x is double;
    if (x is double) { }
    try { x as double; } on CastError catch (e) { }
    try { var z = x as double; } on CastError catch (e) { }
    y is int;
    if (y is int) { }
    try { y as int; } on CastError catch (e) { }
    try { var z = y as int; } on CastError catch (e) { }

    "${1.5}";
    var z = "${1.5}";
    (1.5).toString();
    z = (1.5).toString();
    "$y";
    z = "$y";
    y.toString();
    z = y.toString();

    var a = "xyz";
    var b = "xyz";
    b = b.substring(1);
    if (identical(a, b)) { }

    if (identical(x, y)) { }
    if (identical(y, x)) { }
  }
}

g(x, y) => f(x, y);  // Test inlining calls.
h(x, y) => g(x, y);

// We don't test for _JavascriptCompatibilityError since it's not visible.
// It should not be visible since it doesn't exist on dart2js.
bool isJavascriptCompatibilityError(e) =>
    e is Error && "$e".contains("Javascript Compatibility Error");

main() {
  // The warning (or error in case of --warning_as_error) is issued at
  // most once per location.
  var numWarnings = 0;
  for (var i = 0; i < 20; i++) {
    try {
      h(i, i * 1.0);
    } catch(e) {
      Expect.isTrue(isJavascriptCompatibilityError(e));
      numWarnings++;
    }
  }
  Expect.equals(1, numWarnings);
  // No warnings (errors) should be issued after this point.
  for (var i = 0; i < 20; i++) {
    k(i * 1.0, i);
    k(i * 1.0, i + 0.5);
  }
}

