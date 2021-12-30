// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Unittest test of the CPS ir generated by the analyzer2dart compiler.

import 'mock_sdk.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/src/generated/element.dart';
import 'package:analyzer/src/generated/sdk.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:compiler/src/cps_ir/cps_ir_nodes.dart';
import 'package:compiler/src/cps_ir/cps_ir_nodes_sexpr.dart';
import 'package:compiler/src/elements/elements.dart' as dart2js;
import 'package:unittest/unittest.dart';

import '../lib/src/closed_world.dart';
import '../lib/src/driver.dart';
import '../lib/src/converted_world.dart';
import 'output_helper.dart';
import 'test_helper.dart';
import 'sexpr_data.dart';

main(List<String> args) {
  performTests(TEST_DATA, unittester, checkResult, args);
}

checkResult(TestSpec result) {
  if (result.skipInAnalyzerFrontend) return;
  String input = result.input.trim();
  CollectingOutputProvider outputProvider = new CollectingOutputProvider();
  MemoryResourceProvider provider = new MemoryResourceProvider();
  DartSdk sdk = new MockSdk();
  Driver driver = new Driver(provider, sdk, outputProvider);
  String rootFile = '/root.dart';
  provider.newFile(rootFile, input);
  Source rootSource = driver.setRoot(rootFile);
  FunctionElement entryPoint = driver.resolveEntryPoint(rootSource);
  ClosedWorld world = driver.computeWorld(entryPoint);
  ConvertedWorld convertedWorld = convertWorld(world);

  void checkOutput(String elementName,
                   dart2js.Element element,
                   String expectedOutput) {
    RootNode ir = convertedWorld.getIr(element);
    if (expectedOutput == null) {
      expect(ir, isNull,
          reason: "\nInput:\n${result.input}\n"
                  "No CPS IR expected for $element");
    } else {
      expect(ir, isNotNull,
          reason: "\nInput:\n${result.input}\n"
                  "No CPS IR for $element");
      expectedOutput = expectedOutput.trim();
      String output = ir.accept(new SExpressionStringifier());
      expect(output, equals(expectedOutput),
          reason: "\nInput:\n${result.input}\n"
                  "Expected for '$elementName':\n$expectedOutput\n"
                  "Actual for '$elementName':\n$output\n");
    }
  }

  if (result.output is String) {
    checkOutput('main', convertedWorld.mainFunction, result.output);
  } else {
    assert(result.output is Map<String, String>);
    dart2js.LibraryElement mainLibrary = convertedWorld.mainFunction.library;
    result.output.forEach((String elementName, String output) {
      bool found = false;
      List<String> names = <String>[];
      convertedWorld.resolvedElements.forEach((dart2js.Element element) {
        if (element.library == mainLibrary) {
          String name = element.name;
          if (element.enclosingClass != null) {
            name = '${element.enclosingClass.name}.$name';
          }
          if (name == elementName) {
            checkOutput(elementName, element, output);
            found = true;
          }
          names.add(name);
        }
      });
      expect(found, isTrue, reason: "'$elementName' not found in $names.");
    });
  }
}

