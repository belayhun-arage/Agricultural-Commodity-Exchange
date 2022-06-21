import 'package:http/http.dart';

import '../../libs.dart';

class NewStoreForm extends StatefulWidget {
  int ownerID;
  NewStoreForm({required this.ownerID});

  @override
  State<NewStoreForm> createState() => _NewStoreFormState();
}

class _NewStoreFormState extends State<NewStoreForm> {
  TextEditingController storeNameController = TextEditingController();

  TextEditingController kebeleController = TextEditingController();
  TextEditingController woredaController = TextEditingController();
  TextEditingController cityControler = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController uniqueAddressController = TextEditingController();
  TextEditingController latitudeControler = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  String message = "";
  Color messageColor = Colors.white;
  bool onProgress = false;
  final _storeFormKey = GlobalKey<FormState>();

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(30.653690770268437, 30.653690770268437), zoom: 0.0);

  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: BackButton(),
        ),
        title: Text(
          " Create Store ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 3,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _storeFormKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: messageColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 4,
                          ),
                          height: MediaQuery.of(context).size.height / 50,
                          width: MediaQuery.of(context).size.width - 20,
                          // height: 30,
                          child: Center(
                            child: onProgress
                                ? LinearProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Text(
                                    message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: messageColor,
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 20,
                          width: MediaQuery.of(context).size.width - 24,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter store name';
                              }
                              return null;
                            },
                            cursorColor: Theme.of(context).primaryColorLight,
                            controller: storeNameController,
                            decoration: InputDecoration(
                              labelText: "Store Name",
                              fillColor: Colors.lightBlue,
                              hoverColor: Colors.lightBlue,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlue,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        woredaCity(context),
                        SizedBox(
                          height: 10,
                        ),
                        uniqueAddress(context),
                        SizedBox(
                          height: 10,
                        ),
                        zoneRegion(context),
                        SizedBox(
                          height: 10,
                        ),
                        LatLon(context),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Stack(
                            children: [
                              Expanded(
                                child: MapPicker(
                                  // pass icon widget
                                  iconWidget: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  //add map picker controller
                                  mapPickerController: mapPickerController,
                                  child: GoogleMap(
                                    myLocationEnabled: true,
                                    zoomControlsEnabled: false,
                                    // hide location button
                                    myLocationButtonEnabled: false,
                                    mapType: MapType.hybrid,
                                    //  camera position
                                    initialCameraPosition: cameraPosition,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    onCameraMoveStarted: () {
                                      // notify map is moving
                                      mapPickerController.mapMoving!();
                                      textController.text = "checking ...";
                                    },
                                    onCameraMove: (cameraPosition) {
                                      this.cameraPosition = cameraPosition;
                                    },
                                    onCameraIdle: () async {
                                      // notify map stopped moving
                                      mapPickerController.mapFinishedMoving!();
                                      //get address name from camera position
                                      List<Placemark> placemarks =
                                          await placemarkFromCoordinates(
                                        cameraPosition.target.latitude,
                                        cameraPosition.target.longitude,
                                      );

                                      // update the ui with the address
                                      uniqueAddressController.text =
                                          '${placemarks.first.name}';
                                      regionController.text =
                                          '${placemarks.first.administrativeArea}';
                                      zoneController.text =
                                          '${placemarks.first.subAdministrativeArea}';
                                      cityControler.text =
                                          '${placemarks.first.locality}';
                                      woredaController.text =
                                          '${placemarks.first.subLocality}';
                                      kebeleController.text =
                                          '${placemarks.first.street}';
                                      textController.text =
                                          '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.01,
                                width: MediaQuery.of(context).size.width - 20,
                                height: 50,
                                child: TextFormField(
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                  controller: textController,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.3 +
                                    35,
                                left: MediaQuery.of(context).size.width * 0.305,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextButton(
                                        child: const Text(
                                          "Track Location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 19,
                                            // height: 19/19,
                                          ),
                                        ),
                                        onPressed: () {
                                          latitudeControler.text =
                                              '${cameraPosition.target.latitude}';
                                          longitudeController.text =
                                              '${cameraPosition.target.longitude}';
                                          print(
                                              "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                                          print(
                                              "Address: ${textController.text}");
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(
                                                      255, 228, 223, 223)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor),
                                animationDuration: Duration(seconds: 1),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                              child: Text(
                                "Create",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                final bool checker = _trySubmitForm();
                                if (checker) {
                                  setState(() {
                                    onProgress = true;
                                  });
                                  final response = await context
                                      .read<StoreBloc>()
                                      .createNewStore(CreateNewStoreEvent(
                                          ownerID: widget.ownerID,
                                          storeName: storeNameController.text,
                                          kebele: kebeleController.text,
                                          city: cityControler.text,
                                          woreda: woredaController.text,
                                          zone: zoneController.text,
                                          region: regionController.text,
                                          unique_address:
                                              uniqueAddressController.text,
                                          latitude:
                                              cameraPosition.target.latitude,
                                          longitude:
                                              cameraPosition.target.latitude));

                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    context.read<StoreBloc>().add(
                                        LoadMyStoresEvent(
                                            ownerId: widget.ownerID));
                                    setState(() {
                                      onProgress = false;
                                      message = "Successfully Created";
                                    });

                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      onProgress = false;
                                      message = "Please Try Again";
                                    });
                                  }
                                }
                                print("Outside input validation done");
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget woredaCity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: cityControler,
            decoration: InputDecoration(
              labelText: "City",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: woredaController,
            decoration: InputDecoration(
              labelText: "Woreda",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget uniqueAddress(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: kebeleController,
            decoration: InputDecoration(
              labelText: "Kebele",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: uniqueAddressController,
            decoration: InputDecoration(
              labelText: "Unique Address",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.location_history_sharp),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget zoneRegion(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: zoneController,
            decoration: InputDecoration(
              labelText: "Zone",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: regionController,
            decoration: InputDecoration(
              labelText: "Region",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget LatLon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter latitude value';
              }

              return null;
            },
            cursorColor: Theme.of(context).primaryColorLight,
            controller: latitudeControler,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: "Latitude",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter latitude value';
              }
              return null;
            },
            cursorColor: Theme.of(context).primaryColorLight,
            controller: longitudeController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2),
              labelText: "Longitude",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _trySubmitForm() {
    bool isValid = false;
    if (_storeFormKey.currentState != null) {
      isValid = _storeFormKey.currentState!.validate();
    }
    return isValid;
    // if (isValid == true) {
    //   debugPrint('Everything looks good!');
    //   debugPrint(emailController.text);
    //   debugPrint(firstnameController.text);
    //   debugPrint(lastnameController.text);

    //   /*
    //   Continute proccessing the provided information with your own logic
    //   such us sending HTTP requests, savaing to SQLite database, etc.
    //   */
    // }
  }
}
