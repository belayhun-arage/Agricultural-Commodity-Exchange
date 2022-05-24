import 'dart:math';

bool validatePhoneNumber(String value) {
  // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String pattern =
      r"(^\\+[0-9]{2}|^\\+[0-9]{2}\\(0\\)|^\\(\\+[0-9]{2}\\)\\(0\\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\\-\\s]{10}$)";
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getDuration(int unix) {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int now = (DateTime.now().millisecondsSinceEpoch / 1000).round();
  hours = ((now - unix) / (3600)).round();
  unix = unix- (hours * 3600);
  minutes = ((now - unix) / (60)).round();
  unix = unix- (minutes * 60);
  seconds = ((now - unix)).round();
  String messages ='';
  if (hours>0){
    messages = "$hours hr. $messages";
  }
  if(minutes >0 ){
    messages = "$messages: $minutes min. ";
  }
  if(seconds >0 ){
    messages = "$messages: $seconds sec. ";
  }
  messages = "$messages ago";
  return messages;
}
