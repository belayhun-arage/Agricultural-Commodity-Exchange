import 'package:path/path.dart';
import "../../libs.dart";

class UploadProductPostImages extends StatefulWidget {
  static const String RouteName = "/upload_products_post_image";
  ProductPost post;
  UploadProductPostImages(this.post, {Key? key}) : super(key: key);

  @override
  State<UploadProductPostImages> createState() =>
      _UploadProductPostImagesState();
}

class _UploadProductPostImagesState extends State<UploadProductPostImages> {
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          translate(lang, "Product Pictures Upload"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  translate(lang,
                      "Select images and upload the products pictures!\\nYou are allowed to upload at most 5 pictures for a single product."),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                    children: images.length > 0
                        ? images.map<Widget>((file) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.8,
                                child: Stack(
                                  children: [
                                    Image.file(file),
                                    Positioned(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                        child: Container(
                                          color: Colors.white,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete_forever_sharp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              // setState(() {
                                              images.remove(file);
                                              // });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList()
                        : [
                            Container(
                              child: Text(
                                translate(
                                  lang,
                                  "No image is selected",
                                ),
                              ),
                            ),
                          ]),
              ),
              GestureDetector(
                onTap: () async {
                  // final image = await ImagePicker()
                  //     .pickImage(source: ImageSource.gallery);

                  // if (image == null) return;

                  // final location = await getApplicationDocumentsDirectory();
                  // final name = basename(image.name);
                  // final imageFile = File('\${location.path\}/\$name');
                  // final newImage = await File(image.path).copy(imageFile.path);

                  // // context.read<ProductsBloc>().add(AddImageToPost(
                  // //     imageFile: imageFile, pID: widget.post.id));
                  // images.add(imageFile);
                  // // setState(() {});
                  ImagePicker picker = ImagePicker();
                  XFile pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      maxHeight: 500,
                      maxWidth: 500) as XFile;
                  File imageFile = File(pickedImage.path);
                  // setState(() async{
                  //   images = images.add(imageFile);
                  // });
                  context.read<ProductsBloc>().add(AddImageToPost(
                      imageFile: imageFile, pID: widget.post.id));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          translate(lang, "Select image"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add_a_photo,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
