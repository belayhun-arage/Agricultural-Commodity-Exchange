import '../../libs.dart';

class AdminsListView extends StatelessWidget {
  final List<Admin> admins;
  AdminsListView(this.admins);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: admins.length,
          itemBuilder: (context, counter) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Material(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(
                                  requestedUser: admins[counter],
                                ),
                              ),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: (admins[counter].imgurl != '')
                                    ? Image.asset(
                                        admins[counter].imgurl,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.person,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 7.5,
                            ),
                            Text(
                                admins[counter].firstname +
                                    " " +
                                    admins[counter].lastname,
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ],
                        ),
                      ),
                      IconButton(
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
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: deleteAgentDialog(
                                        admins[counter].id, context),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget deleteAgentDialog(int adminID, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                "Are You Sure To Delete This Admin?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
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
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      animationDuration: Duration(seconds: 1),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    onPressed: () {
                      context
                          .read<MercahntsBloc>()
                          .add(DeleteMerchantEvent(userID: adminID));
                    },
                    child: Text("Delete"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
