// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * Support for client code that extends the analysis server by adding new code
 * completion contributors.
 *
 * Plugins can register completion contributors. The registered contributors
 * will be used to get completions any time a client issues a
 * 'completion.getSuggestions' request.
 *
 * If a plugin wants to add completions, it should implement the class
 * [CompletionContributor] and then register the contributor by including code
 * like the following in the plugin's registerExtensions method:
 *
 *     @override
 *     void registerExtensions(RegisterExtension registerExtension) {
 *       ...
 *       registerExtension(
 *           COMPLETION_CONTRIBUTOR_EXTENSION_POINT_ID,
 *           new MyCompletionContributor());
 *       ...
 *     }
 */
library analysis_server.plugin.completion;

import 'package:analysis_server/completion/completion_core.dart';
import 'package:analysis_server/src/plugin/server_plugin.dart';
import 'package:plugin/plugin.dart';

/**
 * The identifier of the extension point that allows plugins to register code
 * completion contributors. The object used as an extension must be a
 * [CompletionContributor].
 */
final String COMPLETION_CONTRIBUTOR_EXTENSION_POINT_ID = Plugin.join(
    ServerPlugin.UNIQUE_IDENTIFIER,
    ServerPlugin.COMPLETION_CONTRIBUTOR_EXTENSION_POINT);
