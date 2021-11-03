import 'dart:math';

String generateRandomString() {
  var r = Random.secure();
  const _chars = 'abcdefhijklmnopqrst';
  return _chars[r.nextInt(_chars.length)];
}


String getSourceName(String img) => 'assets/images/$img.png';