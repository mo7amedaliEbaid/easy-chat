/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return const String.fromEnvironment('4cef9fe24c504282aadc33ec3abe1b3d',
      defaultValue: '4cef9fe24c504282aadc33ec3abe1b3d');
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('007eJxTYFh4u8rDZxWn6OHHlt/kBX1vcvI/6J6yMiRBtZmn/LRR2VEFBpPk1DTLtFQjk2RTAxMjC6PExJRkY+PUZOPEpFTDJOOUT582pDQEMjLET8tlYIRCEJ+FITc/OYOBAQArPx/i',
      defaultValue: '007eJxTYFh4u8rDZxWn6OHHlt/kBX1vcvI/6J6yMiRBtZmn/LRR2VEFBpPk1DTLtFQjk2RTAxMjC6PExJRkY+PUZOPEpFTDJOOUT582pDQEMjLET8tlYIRCEJ+FITc/OYOBAQArPx/i');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return const String.fromEnvironment(
    'moch',
    defaultValue: 'moch',
  );
}

/// Your int user ID
const int uid = 0;

/// Your user ID for the screen sharing
const int screenSharingUid = 10;

/// Your string user ID
const String stringUid = '0';

String get musicCenterAppId {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('MUSIC_CENTER_APPID',
      defaultValue: '<MUSIC_CENTER_APPID>');
}