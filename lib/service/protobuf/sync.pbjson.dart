///
//  Generated code. Do not modify.
//  source: sync.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const SyncRequest$json = const {
  '1': 'SyncRequest',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'localHead', '3': 2, '4': 1, '5': 5, '10': 'localHead'},
  ],
};

const SyncResponse$json = const {
  '1': 'SyncResponse',
  '2': const [
    const {'1': 'remoteHead', '3': 1, '4': 1, '5': 5, '10': 'remoteHead'},
    const {'1': 'actionsLength', '3': 2, '4': 1, '5': 5, '10': 'actionsLength'},
    const {'1': 'actions', '3': 3, '4': 3, '5': 9, '10': 'actions'},
  ],
};

const PushRequest$json = const {
  '1': 'PushRequest',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'contentId', '3': 3, '4': 1, '5': 9, '10': 'contentId'},
  ],
};

const PushResponse$json = const {
  '1': 'PushResponse',
  '2': const [
    const {'1': 'remoteHead', '3': 1, '4': 1, '5': 5, '10': 'remoteHead'},
  ],
};

