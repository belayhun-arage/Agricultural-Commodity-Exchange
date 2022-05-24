import '../../libs.dart';
import '../../theme.dart';

class UserAccountePage extends StatefulWidget {
  User user;
  UserAccountePage({required this.user});

  @override
  State<UserAccountePage> createState() => _UserAccountePageState();
}

class _UserAccountePageState extends State<UserAccountePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProfileScreen.RouteName);
        },
        child: Row(
          children: [
            CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/pp.jpg",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.user.firstname,
              style: UserNameFontStyle,
            )
          ],
        ),
      ),
    );
    // return Drawer(
    //   child: ListView(
    //     children: [
    //       UserAccountsDrawerHeader(
    //           accountName: Text(
    //             "User Name",
    //           ),
    //           accountEmail: Text("user@gmail.com"),
    //           currentAccountPicture: CircleAvatar(
    //             child: ClipOval(
    //               child: Image.asset(
    //                 'images/pp.jpg',
    //                 width: 50,
    //                 height: 50,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           )),
    //     ],
    //   ),
    // );
  }
}
