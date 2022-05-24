class MessageOnly {
  String msg;
  bool succesful;
  MessageOnly(this.msg, this.succesful);
  factory MessageOnly.fromJson(Map<String, dynamic> json, bool success) {
    String msgs = "${json['msg']}";
    return MessageOnly(msgs, success);
  }
}
