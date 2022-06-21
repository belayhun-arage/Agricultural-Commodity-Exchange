import "../../libs.dart";

void showMap(BuildContext context, double latitude, double longitude,
    {String title = ""}) async {
  await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext cxt) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                              child: Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Stack(
                                  children: <Widget>[
                                    MapView(latitude, longitude, title: title),
                                    Positioned.fill(
                                      right: 0.0,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(
                                              Icons.close_outlined,
                                              size: 30,
                                              color: Colors.red,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
}
