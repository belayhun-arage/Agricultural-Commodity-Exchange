import 'package:agri_net_frontend/profile/widgets/widgets.dart';

import '../../libs.dart';

class AddressView extends StatefulWidget {
  final Address address;
  AddressView(this.address);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final _controller = Completer<GoogleMapController>();

  MapPickerController mapPickerController = MapPickerController();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double lat = widget.address.Latitude;
    double lon = widget.address.Longitude;
    CameraPosition cameraPosition =
        CameraPosition(target: LatLng(lat, lon), zoom: 0.0);

    return ExpansionTile(
      textColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).primaryColor,
      title: Text(
        "Address",
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              (widget.address.UniqueAddressName != '')
                  ? Row(
                      children: [
                        Text("Unique : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.UniqueAddressName}',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    )
                  : SizedBox(),
              (widget.address.Kebele != '')
                  ? Row(
                      children: [
                        Text("Kebele : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.Kebele}',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    )
                  : SizedBox(),
              (widget.address.Woreda != '')
                  ? Row(
                      children: [
                        Text("Woreda : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.Woreda}',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    )
                  : SizedBox(),
              (widget.address.City != '')
                  ? Row(
                      children: [
                        Text("City : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.City}',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    )
                  : SizedBox(),
              (widget.address.Zone != '')
                  ? Row(
                      children: [
                        Text("Zone : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.Zone}',
                            style: TextStyle(
                              fontSize: 16,
                            ))
                      ],
                    )
                  : SizedBox(),
              (widget.address.Region != '')
                  ? Row(
                      children: [
                        Text("Region : ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${widget.address.Region},',
                            style: TextStyle(
                              fontSize: 16,
                            ))
                      ],
                    )
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text("Created At ${state.myStores[counter].createdAt}",
                  //     style:
                  //         TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  IconButton(
                      iconSize: 40,
                      onPressed: () {
                        showDialog(
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
                                    MapView(lat, lon, title : "Address"),
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
                      },
                      color: Colors.redAccent,
                      icon: Icon(Icons.location_on_rounded)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
