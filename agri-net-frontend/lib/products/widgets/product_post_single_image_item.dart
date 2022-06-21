import "../../libs.dart";
import "dart:convert";

class ProductPostSingleImageItem extends StatefulWidget {
  int imageID;
  ProductPostSingleImageItem(this.imageID, {Key? key}) : super(key: key);

  @override
  _ProductPostImageItemState createState() =>
      _ProductPostImageItemState(this.imageID);
}

class _ProductPostImageItemState extends State<ProductPostSingleImageItem> {
  bool loadFullImage = false;
  int imageID;
  _ProductPostImageItemState(this.imageID) {
    url =
        "${StaticDataStore.SCHEME}://${StaticDataStore.HOST}:${StaticDataStore.PORT}/post/image/${this.imageID}/blurred/";
  }
  String url = "";

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(
        {"authorization": StaticDataStore.HEADERS["authorization"]!}));
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColorLight),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(children: [
            Image.network(
              url,
              headers: {
                "authorization": "Bearer ${StaticDataStore.USER_TOKEN}"
              },
              errorBuilder: (context, _, er) {
                return Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: 0.4,
                      duration: Duration(
                        seconds: 2,
                      ),
                      child: Container(
                        color: Color.fromARGB(40, 49, 48, 48),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          // color: Color.fromARGB(5, 0, 0, 0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.width * 0.25,
                          child: Container(
                            // color: Color.fromARGB(40, 26, 25, 25),
                            child: Icon(
                              widget.imageID == 0 ? Icons.close : Icons.refresh,
                              color: widget.imageID == 0
                                  ? Colors.red
                                  : Theme.of(context).primaryColorDark,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            imageID != 0 && !loadFullImage
                ? Positioned(
                    top: 10,
                    left: constraints.maxWidth * 0.4,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                          )),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {
                            setState(() {
                              this.loadFullImage = true;
                              this.url =
                                  "${StaticDataStore.SCHEME}://${StaticDataStore.HOST}:${StaticDataStore.PORT}/post/image/${this.imageID}";
                            });
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ]);
        }),
      ),
    );
  }
}
