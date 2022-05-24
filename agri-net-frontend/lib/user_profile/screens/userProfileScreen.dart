import '../../libs.dart';

// void main() {
//   runApp(ProfileScreen());

//   // Handles Status and Nav bar styling/theme
//   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   //   systemNavigationBarColor: Colors.transparent,
//   //   statusBarColor: Colors.transparent,
//   //   statusBarIconBrightness: Brightness.dark,
//   // ));
// }

class ProfileScreen extends StatefulWidget {
  static const String RouteName = "profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            "Edit Profile",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: ProfilePage());
  }
}
