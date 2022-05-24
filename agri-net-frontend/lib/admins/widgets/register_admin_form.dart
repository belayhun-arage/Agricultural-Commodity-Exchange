import 'package:path/path.dart';

import '../../libs.dart';

class RegisterAdminPage extends StatefulWidget {
  static String RouteName = "admin";
  const RegisterAdminPage({Key? key}) : super(key: key);

  @override
  State<RegisterAdminPage> createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends State<RegisterAdminPage> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 5,
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: BackButton()),
        title: Text(
          "Register New Admin",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                firstLastName(context),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).primaryColorLight,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.mail_outline),
                    ),
                  ),
                ),
                emailPhone(context),
                woredaCity(context),
                uniqueAddress(context),
                zoneRegion(context),
                latLon(context)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Container(
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () async {
                  final state = await context.read<AdminsBloc>().registerAdmin(
                      CreateNewAdminEvent(
                          firstname: firstnameController.text,
                          lastname: lastnameController.text,
                          email: emailController.text,
                          phone: phoneControler.text,
                          kebele: kebeleController.text,
                          city: cityControler.text,
                          woreda: woredaController.text,
                          zone: zoneController.text,
                          region: regionController.text,
                          unique_address: uniqueAddressController.text,
                          latitude: double.parse(latitudeControler.text),
                          longitude: double.parse(longitudeController.text)));
                  if (state is NewAdminCreatedState) {
                    print("\n\n");
                    print(state);
                    print("\n\n");
                    context.read<AdminsBloc>().add(GetAllAdminsEvent());
                    Navigator.of(context).pushNamed(AdminsScreen.RouteName);
                  }
                  if (state is FailedToCreateAdminState) {
                    print("\n\n");
                    print(state);
                    print("\n\n");
                    context.read<AdminsBloc>().add(FailedToCreateAdminEvent(
                        msg: "Failed to register the user"));
                    Navigator.of(context).pushNamed(AdminsScreen.RouteName);
                  }
                },
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstLastName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: firstnameController,
            decoration: InputDecoration(
              labelText: "FirstName",
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
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
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
          child: TextField(
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

  Widget latLon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: latitudeControler,
            decoration: InputDecoration(
              labelText: "Latitude",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.location_pin),
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
            controller: longitudeController,
            decoration: InputDecoration(
              labelText: "Longitude",
              fillColor: Colors.lightBlue,
              hoverColor: Colors.lightBlue,
              suffixIcon: Icon(Icons.location_pin),
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
}
