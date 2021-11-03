import 'dart:math';

String generateRandomString() {
  var r = Random.secure();
  const _chars = 'abcdefghijklmnopqrstuz';
  return _chars[r.nextInt(_chars.length)];
}
