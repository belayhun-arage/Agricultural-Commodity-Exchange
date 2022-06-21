import '../../libs.dart';

class UserAccountePage extends StatefulWidget {
  @override
  State<UserAccountePage> createState() => _UserAccountePageState();
}

class _UserAccountePageState extends State<UserAccountePage> {
  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
    User theUser = (_userBloc.state as Authenticated).user;
    if (theUser is Merchant) {
      BlocProvider.of<StoreBloc>(context)
          .add(LoadMyStoresEvent(ownerId: theUser.id));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if ((_userBloc.state is Authenticated)) {
            Navigator.pushNamed(context, UserProfileScreen.RouteName,
                arguments: theUser);
          }
        },
        child: Row(
          children: [
            ((_userBloc.state is Authenticated))
                ? CircleAvatar(
                    child: ClipOval(
                      child: (theUser.imgurl != '')
                          ? Image.network(
                              '${StaticDataStore.URI}${theUser.imgurl}',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                            ),
                    ),
                  )
                : Container(),
            SizedBox(
              width: 10,
            ),
            ((_userBloc.state is Authenticated))
                ? Text(
                    theUser.firstname,
                    style: UserNameFontStyle,
                  )
                : Container()
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
