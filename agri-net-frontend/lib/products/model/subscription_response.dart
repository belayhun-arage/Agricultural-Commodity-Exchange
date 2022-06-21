class SubscriptionResponse{

}

class StatusAndMessage{
  int statusCode;
  String msg;
  
  StatusAndMessage(this.statusCode, this.msg);


  factory StatusAndMessage.fromJson(Map<String, dynamic> json){
    return StatusAndMessage(
      json["status_code"]??999,
      json['msg']??"");
  } 
}