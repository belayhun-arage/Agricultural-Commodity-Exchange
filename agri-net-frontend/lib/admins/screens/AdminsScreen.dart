import 'dart:ffi';

import '../../libs.dart';

class AdminsScreen extends StatefulWidget {
  static String RouteName = "admins";
  const AdminsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdminsBloc>(context).add(GetAllAdminsEvent());
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
            "Registered Admins",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RegisterAdminPage.RouteName);
                  },
                  icon: Icon(Icons.add),
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RegisterAdminPage.RouteName);
                    },
                    child: Text(
                      "New",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<AdminsBloc, AdminsState>(builder: (context, state) {
          if (state is GetAllAdminsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AllAdminsRetrievedState) {
            return Column(
              children: [
                Expanded(
                  child: userRow(state.usersList),
                ),
              ],
            );
          }
          if (state is NoAdminFoundState) {
            return Column(
              children: [
                Text("No User is registered yet!"),
              ],
            );
          }
          return Column(
            children: [
              Text("Some thing went wrong"),
            ],
          );
        }));
  }

  Widget userRow(List<User> users) {
    return Flexible(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, counter) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Material(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: Image.asset(
                                  users[counter].imgurl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.5,
                            ),
                            Text(users[counter].firstname),
                          ],
                        ),
                        Text(StaticDataStore.ROLE),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
