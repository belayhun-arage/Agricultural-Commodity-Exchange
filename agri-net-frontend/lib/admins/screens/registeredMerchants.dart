import '../../libs.dart';

class RegisteredMerchantsScreen extends StatefulWidget {
  static String RouteName = "merchants";
  const RegisteredMerchantsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredMerchantsScreen> createState() =>
      _RegisteredMerchantsScreenState();
}

class _RegisteredMerchantsScreenState extends State<RegisteredMerchantsScreen> {
  @override
  void initState() {
    super.initState();
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
            "Registered Merchants",
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
          if (state is GetAllMerchantsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AllMerchantsFechedState) {
            return Column(
              children: [
                Expanded(
                  child: merchantRow(state.merchants),
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
    ;
  }

  Widget merchantRow(List<Merchant> merchants) {
    return Flexible(
      child: ListView.builder(
          itemCount: merchants.length,
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
                                  "assets/images/pp.jpg",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.5,
                            ),
                            Text(merchants[counter].postsCounte.toString()),
                            Text(merchants[counter].storeCount.toString()),
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
