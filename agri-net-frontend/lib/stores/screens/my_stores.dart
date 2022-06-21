import 'package:agri_net_frontend/profile/widgets/address.dart';

import '../../libs.dart';

class MyStoresScreen extends StatefulWidget {
  static String RouteName = "/stores";
  MyStoresScreen();

  @override
  State<MyStoresScreen> createState() => _MyStoresScreenState();
}

class _MyStoresScreenState extends State<MyStoresScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myStoresProvider = BlocProvider.of<StoreBloc>(context);
    if (!(myStoresProvider.state is MyStoresInit)) {
      myStoresProvider.add(LoadMyStoresEvent(ownerId: StaticDataStore.ID));
    }
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
          " My Stores ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state is LoadingMyStoresState) {
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
                if (state is MyStoresLoadedState) {
                  if ((state.myStores[StaticDataStore.ID]) != null &&
                      (state.myStores[StaticDataStore.ID])!.length > 0) {
                    final stores = state.myStores[StaticDataStore.ID];
                    return Flexible(
                        child: ListView.builder(
                            itemCount: stores!.length,
                            itemBuilder: (context, counter) {
                              return StoreView(stores[counter]);
                            }));
                  }
                  return Flexible(
                      child: (state.myStores[StaticDataStore.ID]) != null
                          ? ListView.builder(
                              itemCount:
                                  state.myStores[StaticDataStore.ID]!.length,
                              itemBuilder: (context, counter) {
                                return StoreView(state
                                    .myStores[StaticDataStore.ID]![counter]);
                              })
                          : Center());
                }

                return Center(
                  child: Column(
                    children: [
                      Text("No Store Instance found"),
                      IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          context.read<StoreBloc>().add(
                              LoadMyStoresEvent(ownerId: StaticDataStore.ID));
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
