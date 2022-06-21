import '../../libs.dart';

class AgentInstanceForm extends StatefulWidget {
  const AgentInstanceForm({Key? key}) : super(key: key);

  @override
  State<AgentInstanceForm> createState() => _AgentInstanceFormState();
}

class _AgentInstanceFormState extends State<AgentInstanceForm> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneControler = TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(30.653690770268437, 30.653690770268437), zoom: 0.0);

  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneControler.dispose();
    kebeleController.dispose();
    cityControler.dispose();
    uniqueAddressController.dispose();
    woredaController.dispose();
    zoneController.dispose();
    regionController.dispose();
    latitudeControler.dispose();
    longitudeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                key: _formKey,
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
                            height:
                                MediaQuery.of(context).size.height * 0.4 + 30,
                            child: Column(
                              children: [
                                firstLastName(context),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    cursorColor:
                                        Theme.of(context).primaryColorLight,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.mail_outline),
                                    ),
                                    onChanged: (value) => emailController,
                                  ),
                                ),
                                emailPhone(context),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Address:",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                woredaCity(context),
                                uniqueAddress(context),
                                zoneRegion(context),
                                LatLon(context)
                              ],
                            ),
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.4 - 40,
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
                                        mapPickerController
                                            .mapFinishedMoving!();
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
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
                                  top: MediaQuery.of(context).size.height *
                                          0.25 +
                                      35,
                                  left:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                MaterialStateProperty
                                                    .all<Color>(Color.fromARGB(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor),
                                    animationDuration: Duration(seconds: 1),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                  ),
                                  onPressed: () async {
                                    bool validated = _trySubmitForm();
                                    if (validated) {
                                      setState(() {
                                        onProgress = true;
                                      });
                                      final response = await context
                                          .read<AgentsBloc>()
                                          .registerAgent(NewAgentEvent(
                                              firstname:
                                                  firstnameController.text,
                                              lastname: lastnameController.text,
                                              email: emailController.text,
                                              phone: phoneControler.text,
                                              kebele: kebeleController.text,
                                              city: cityControler.text,
                                              woreda: woredaController.text,
                                              zone: zoneController.text,
                                              region: regionController.text,
                                              unique_address:
                                                  uniqueAddressController.text,
                                              latitude: cameraPosition
                                                  .target.latitude,
                                              longitude: cameraPosition
                                                  .target.latitude));
                                      if (response.statusCode == 200) {
                                        setState(() {
                                          onProgress = false;
                                          message = "Successfully Created";
                                        });
                                        context.read<AgentsBloc>().add(
                                            LoadMyAgentsEvent(
                                                adminID: StaticDataStore.ID));
                                      } else {
                                        setState(() {
                                          onProgress = false;
                                          message = "Please Try Again";
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ],
                          ),
                          // Container(
                          //   height: MediaQuery.of(context).size.height * 0.05,
                          //   child: Container(
                          //     height: MediaQuery.of(context).size.height / 25,
                          //     width: MediaQuery.of(context).size.width / 3,
                          //     decoration: BoxDecoration(
                          //         color: Theme.of(context).primaryColor,
                          //         borderRadius: BorderRadius.circular(3)),
                          //     child: InkWell(
                          //       onTap: () async {
                          //         bool validated = _trySubmitForm();
                          //         if (validated) {
                          //           final response = await context
                          //               .read<AgentsBloc>()
                          //               .registerAgent(NewAgentEvent(
                          //                   firstname: firstnameController.text,
                          //                   lastname: lastnameController.text,
                          //                   email: emailController.text,
                          //                   phone: phoneControler.text,
                          //                   kebele: kebeleController.text,
                          //                   city: cityControler.text,
                          //                   woreda: woredaController.text,
                          //                   zone: zoneController.text,
                          //                   region: regionController.text,
                          //                   unique_address: uniqueAddressController.text,
                          //                   latitude: cameraPosition.target.latitude,
                          //                   longitude: cameraPosition.target.latitude));
                          //           if (response.statusCode == 200) {
                          //             Navigator.pop(context);
                          //           }
                          //         }
                          //       },
                          //       child: Center(
                          //         child: Text(
                          //           "Register",
                          //           style:
                          //               TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
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

  Widget firstLastName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            cursorColor: Theme.of(context).primaryColorLight,
            controller: firstnameController,
            decoration: InputDecoration(
              labelText: "FirstName",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
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
                return 'Please enter last name';
              }
              return null;
            },
            cursorColor: Theme.of(context).primaryColorLight,
            controller: lastnameController,
            decoration: InputDecoration(
              labelText: "LastName",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.person),
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

  Widget emailPhone(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width - 20,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone';
              }
              // Check if the entered email has the right format
              if (!RegExp(r'(^(?:[+251])?[0-9]{10,12}$)').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
              // Return null if the entered email is valid
              return null;
            },
            cursorColor: Theme.of(context).primaryColorLight,
            controller: phoneControler,
            decoration: InputDecoration(
              labelText: "Phone",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.phone),
            ),
          ),
        ),
      ],
    );
  }

  Widget woredaCity(BuildContext context) {
    return Row(
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
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter latitude value';
              }
              // if (!RegExp(r'(^(?:?[0-9]{1,30}$)').hasMatch(value)) {
              //   return 'Please enter a valid latitude valu';
              // }
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
                return 'Please enter Longitude value';
              }
              // if (!RegExp(r'(^(?:?[0-9]{1,30}$)').hasMatch(value)) {
              //   return 'Please enter a valid latitude valu';
              // }
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
    final bool? isValid = _formKey.currentState?.validate();
    return isValid!;
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
