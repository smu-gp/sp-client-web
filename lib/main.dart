// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_web/material.dart';
import 'package:sp_client/app.dart';
import 'package:sp_client/repository/local/preference_repository.dart';
import 'package:sp_client/repository/remote/history_repository.dart';
import 'package:sp_client/repository/remote/result_repository.dart';

void main() {
  runApp(App(
    historyRepository: RemoteHistoryRepository(),
    resultRepository: RemoteResultRepository(),
    preferenceRepository: LocalPreferenceRepository(),
  ));
}
