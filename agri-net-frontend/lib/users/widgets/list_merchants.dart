import '../../libs.dart';

class MerchantsList extends StatefulWidget {
  const MerchantsList({Key? key}) : super(key: key);

  @override
  State<MerchantsList> createState() => _MerchantsListState();
}

class _MerchantsListState extends State<MerchantsList> {
  TextEditingController searchController = TextEditingController();
  bool editFlag = false;
  int selectedMerchantId = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = BlocProvider.of<StoreBloc>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
          child: Stack(
            children: [
              BlocBuilder<MercahntsBloc, MerchantsState>(
                  builder: (context, state) {
                if (state is MerchantsLoadingState) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                        Text(
                          translate(lang, "loading ..."),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (state is MerchantsLoadedState) {
                  if (state.merchants.length > 0) {
                    for (int i = 0; i < state.merchants.length; i++) {
                      storeProvider.add(
                          LoadMyStoresEvent(ownerId: state.merchants[i].id));
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(child: merchantRow(state.merchants)),
                      (editFlag == true)
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Theme.of(context).primaryColor),
                                        animationDuration: Duration(seconds: 1),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                        ),
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return NewStoreForm(
                                              ownerID: selectedMerchantId);
                                        }));
                                      },
                                      child: Text(
                                        "Add Store",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Theme.of(context).primaryColor),
                                        animationDuration: Duration(seconds: 1),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                        ),
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext cxt) {
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 50, 0, 10),
                                              child: Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: deleteMerchantDialog(
                                                      selectedMerchantId)),
                                            );
                                          },
                                        );

                                        setState(() {
                                          editFlag = false;
                                        });
                                      },
                                      child: Text(
                                        "Remove",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                }
                return Center(
                  child: Column(
                    children: [
                      Text("No Merchant Instance found"),
                      IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          context.read<MercahntsBloc>().add(
                              LoadMyMerchantsEvent(
                                  adminID: StaticDataStore.ID));
                        },
                      )
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    ));
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (t) {
          setState(() {
            // widget.text = t;
          });
        },
        autofocus: true,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        // controller: searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget topBarOfMerchantsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
      child: Material(
        elevation: 10,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: Text(
                      "Merchant",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4 - 19,
                  child: Center(
                    child: Row(
                      children: [
                        Text("Stores",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4 - 19,
                  child: Center(
                    child: Text("Posts",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4 - 19,
                  child: Center(
                    child: Text("Remove",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget merchantRow(List<Merchant> merchants) {
    return ListView.builder(
        itemCount: merchants.length,
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
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(
                                requestedUser: merchants[counter],
                              ),
                            ),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: ClipOval(
                                  child: (merchants[counter].imgurl != '')
                                      ? Image.network(
                                          merchants[counter].imgurl,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.person,
                                        ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                  merchants[counter].firstname +
                                      " " +
                                      merchants[counter].firstname,
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  print(selectedMerchantId);
                                  print(merchants[counter].id);
                                  editFlag = true;
                                  selectedMerchantId = merchants[counter].id;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ))
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }

  Widget editMerchantDialog(int merchantId) {
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
                "Add Store",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewStoreForm(ownerID: merchantId);
                }));
              },
            ),
            ListTile(
              title: Text(
                "Remove",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                deleteMerchantDialog(merchantId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteMerchantDialog(int merchantID) {
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
                "Are You Sure To Delete This Agent?",
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
                      setState(() {
                        editFlag = false;
                      });
                      context
                          .read<MercahntsBloc>()
                          .add(DeleteMerchantEvent(userID: merchantID));

                      context.read<MercahntsBloc>().add(
                          LoadMyMerchantsEvent(adminID: StaticDataStore.ID));

                      Navigator.pop(context, true);
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
