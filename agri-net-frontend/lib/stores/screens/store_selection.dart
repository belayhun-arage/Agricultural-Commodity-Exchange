import '../../libs.dart';

class StoreSelectionScreen extends StatefulWidget {
  static const String RouteName = "/store_selection_screen";
  final List<Store> stores;
  final Function callBack;

  StoreSelectionScreen(this.stores, this.callBack, {Key? key})
      : super(key: key);

  @override
  State<StoreSelectionScreen> createState() => StoreSelectionScreenState();
}

class StoreSelectionScreenState extends State<StoreSelectionScreen> {
  String text = "";

  Store? store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.stores.map((p) {
                                  return GestureDetector(
                                    onTap: () async {
                                      widget.callBack(p);
                                      await Future.delayed(
                                          Duration(seconds: 1));
                                      Navigator.of(context).pop();
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.callBack(p);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    p.storeName,
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    UnixTime(p.createdAt
                                                            .millisecondsSinceEpoch)
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          137, 48, 47, 47),
                                                    ),
                                                  ),
                                                  Text(
                                                    translate(lang, "Address"),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      (p.address
                                                              .UniqueAddressName +
                                                          "/" +
                                                          p.address.Region +
                                                          "/" +
                                                          p.address.Zone),
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            Column(children: [
                                              IconButton(
                                                icon: Icon(
                                                    Icons.location_on_rounded),
                                                onPressed: () {
                                                  showMap(
                                                      context,
                                                      p.address.Latitude,
                                                      p.address.Longitude);
                                                },
                                                color: Colors.red,
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -2,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ));
  }
}
