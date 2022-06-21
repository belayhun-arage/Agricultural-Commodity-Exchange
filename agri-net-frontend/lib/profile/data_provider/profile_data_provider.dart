import 'dart:convert';

import 'package:http/http.dart';

import '../../libs.dart';

class ProfileProvider {
  static Client client = Client();
  Future<void> uploadImage2(File file, int id) async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.111.52/test/image_upload.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int> imageBytes = file.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      var response = await client.put(
          Uri(
            host: StaticDataStore.HOST,
            scheme: "http",
            port: StaticDataStore.PORT,
            path: "/api/user/profile/picture",
          ),
          body: {
            'image': baseimage,
          },
          headers: {
            "Authorization": "Bearer ${StaticDataStore.USER_TOKEN}",
            "Content-type": "multipart/form-data",
            'Accept': 'application/json',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsondata = json.decode(response.body); //decode json data
        if (jsondata["error"]) {
          //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
        print(response.body.isEmpty);
        print(response.statusCode);
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    } catch (e) {
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }
  }

  ///api/user/profile/picture
  Future<DeletePPResponse> deletePP() async {
    var respo = await client.delete(
        Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "api/user/profile/picture"),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});
    print(respo.body);
    if (respo.statusCode == 200 || respo.statusCode == 201) {
      var jsonBody = jsonDecode(respo.body);
      Map<String, dynamic> json = {
        "status_code": respo.statusCode,
        "msg": jsonBody["msg"]
      };
      return DeletePPResponse.fromJson(json);
    }
    return DeletePPResponse(
        statusCode: respo.statusCode, msg: "Something Went Wrong");
  }

  Future<ImageUploadResponse> uploadImage(File file, int id) async {
    print(
        "FILEEEEEEEEEEEEEEEEEEEEEE \n PATHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH\n");
    print(file.path);
    try {
      var stream = ByteStream(file.openRead());
      var length = await file.length();
      var request = MultipartRequest(
        "PUT",
        Uri(
          host: StaticDataStore.HOST,
          scheme: "http",
          port: StaticDataStore.PORT,
          path: "/api/user/profile/picture",
        ),
      );
      request.headers.addAll({
        "Authorization": "Bearer ${StaticDataStore.USER_TOKEN}",
        "Content-type": "multipart/form-data",
      });
      var multipartFile = MultipartFile(
        'image',
        stream,
        length,
        filename: file.path.split('/').last,
        // contentType: MediaType('image', 'jpeg'),
      );
      print("multipartFile \n multipartFile\n");
      print(multipartFile.filename);
      request.files.add(multipartFile);
      final response = await request.send();
      print("response.statusCode \n response.statusCode\n");
      print(response.statusCode);
      final jsonBody = jsonDecode(await response.stream.bytesToString());
      print(jsonBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonBody["msg"] != "") {
          return ImageUploadResponse(id, response.statusCode, jsonBody["msg"],
              msg: STATUS_CODES[response.statusCode]);
        } else {
          return ImageUploadResponse(id, response.statusCode, "",
              msg: STATUS_CODES[response.statusCode]);
        }
      }
      if (jsonBody["err"] == "") {
        return ImageUploadResponse(id, response.statusCode, "",
            msg: STATUS_CODES[response.statusCode]);
      }
      return ImageUploadResponse(id, response.statusCode, "",
          msg: jsonBody["err"]);
    } catch (e) {
      print(
          "EXCEPTIONOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\nOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO\nOOOOOOOOOO\nOOOOO");
      print(e.toString());
      return ImageUploadResponse(id, 500, "",
          msg: "error while uploading an Imange");
    }
  }
}
