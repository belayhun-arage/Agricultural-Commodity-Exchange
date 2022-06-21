import "package:http/http.dart";
import "../../libs.dart";
import "dart:convert";

class ProductProvider {
  Client client = Client();

  // /api/cxp/post/images/:postid

  Future<void> uploadImage2(File file, int id) async {
    try {
      List<int> imageBytes = file.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await client.post(
          Uri(
            host: StaticDataStore.HOST,
            scheme: "http",
            port: StaticDataStore.PORT,
            path: "/api/cxp/post/images/${id}",
          ),
          body: {
            'image': baseimage,
          },
          headers: {
            "Authorization": "Bearer ${StaticDataStore.USER_TOKEN}",
            "Content-type": "multipart/form-data",
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body); //decode json data
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
        print(response.body.isEmpty);
        print(response.statusCode);
      }
    } catch (e) {
      print("Error during converting to Base64");
    }
  }

  Future<ProductPostResponse> createProductPost(ProductPostInput input) async {
    try {
      Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };

      var response = await client.post(
        Uri(
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          scheme: StaticDataStore.SCHEME,
          path: "/api/cxp/post/new",
        ),
        headers: headers,
        body: jsonEncode(input.toJson()),
      );
      print(response.body);
      final body = jsonDecode(response.body) ?? {} as Map<String, dynamic>;
      print(body);
      return ProductPostResponse.fromJson(body);
    } catch (e, a) {
      print(e.toString());
      return ProductPostResponse(
          statusCode: 999, msg: "Connection issue!!!", crop: null);
    }
  }

  Future<ProductsResponse> loadMyProductPosts() async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/cxp/posts",
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        print(bosy);
        return ProductsResponse.fromJson(bosy);
      } else {
        return ProductsResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            posts: []);
      }
    } catch (e, a) {
      print(e.toString());
      return ProductsResponse(
          statusCode: 999, msg: "connection issue!", posts: []);
    }
  }

  Future<ProductsResponse> loadProducts(int offset, int limit) async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/posts",
            queryParameters: {
              "offset": "$offset",
              "limit": "$limit",
            },
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        print(bosy);
        return ProductsResponse.fromJson(bosy);
      } else {
        return ProductsResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            posts: []);
      }
    } catch (e, a) {
      print(e.toString());
      return ProductsResponse(
          statusCode: 999, msg: "connection issue!", posts: []);
    }
  }

  Future<ProductPostResponse> getProductPostResponseByID(int id) async {
    try {
      Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
        Uri(
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          scheme: StaticDataStore.SCHEME,
          path: "/api/post/$id",
        ),
        headers: headers,
      );
      final body = jsonDecode(response.body) ?? {} as Map<String, dynamic>;
      return ProductPostResponse.fromJson(body);
    } catch (e, a) {
      return ProductPostResponse(
          statusCode: 999, msg: "Connection issue!!!", crop: null);
    }
  }
}
