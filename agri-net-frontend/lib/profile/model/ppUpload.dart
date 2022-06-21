class ImageUploadResponse {
  int id;
  String imgurl;
  int statusCode;
  String? msg;
  ImageUploadResponse(this.id, this.statusCode, this.imgurl, {this.msg});
}

class DeletePPResponse {
  int statusCode;
  String msg;
  DeletePPResponse({required this.statusCode, required this.msg});

  factory DeletePPResponse.fromJson(Map<String, dynamic> json) {
    return DeletePPResponse(statusCode: json["status_code"], msg: json["msg"]);
  }
}
