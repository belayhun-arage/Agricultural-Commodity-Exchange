import '../../libs.dart';

class HomeScreen extends StatefulWidget {
  static const String RouteName = "homescreen";
  HomeScreen();

  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  TransactionBloc? transactionProvider;
  NotificationsBloc? notificationProvider;
  @override
  Widget build(BuildContext context) {
    final productTypeProvider = BlocProvider.of<ProductTypeBloc>(context);
    final userProvider = BlocProvider.of<UserBloc>(context);
    final adminProvider = BlocProvider.of<AdminsBloc>(context);
    final agentProvider = BlocProvider.of<AgentsBloc>(context);
    final merchantProvider = BlocProvider.of<MercahntsBloc>(context);
    final storeProvider = BlocProvider.of<StoreBloc>(context);

    if (productTypeProvider.state is ProductTypeInit) {
      productTypeProvider.add(ProductTypesLoadEvent());
    }

    if (StaticDataStore == ROLE_AGENT ||
        StaticDataStore.ROLE == ROLE_MERCHANT) {
      final myProductsBlocProvider = BlocProvider.of<MyProductsBloc>(context);
      if (myProductsBlocProvider.state is MyProductInit) {
        myProductsBlocProvider.add(LoadMyProductsEvent());
      }
    }

    if (userProvider.state is Authenticated) {
      final theUser = (userProvider.state as Authenticated).user;
      if (StaticDataStore.ROLE == ROLE_SUPERADMIN) {
        if (adminProvider.state is AdminsStateInIt) {
          adminProvider.add(LoadAdminsInIt());
        }
      }
      if (theUser is Admin) {
        final theAdmin = theUser as Admin;
        if (agentProvider.state is AgentsInItState) {
          agentProvider.add(LoadMyAgentsEvent(adminID: theAdmin.id));
        }
        if (merchantProvider.state is MerchantsInItState) {
          merchantProvider.add(LoadMyMerchantsEvent(adminID: theAdmin.id));
        }
      }
      if (theUser is Merchant) {
        storeProvider.add(LoadMyStoresEvent(ownerId: StaticDataStore.ID));
      }
    }

    final productsPostProvider = BlocProvider.of<ProductsBloc>(context);
    if (!(productsPostProvider.state is ProductsLoadSuccess)) {
      productsPostProvider.add(LoadProductsEvent());
    }

    if (StaticDataStore.ROLE == ROLE_MERCHANT ||
        StaticDataStore.ROLE == ROLE_AGENT) {
      transactionProvider = BlocProvider.of<TransactionBloc>(context);
      transactionProvider?.add(TransactionLoadEvent());
      transactionProvider?.startLoadTransactionsLoop();

      notificationProvider = BlocProvider.of<NotificationsBloc>(context);
      notificationProvider?.add(NotificationsLoadEvent());
      notificationProvider?.startLoadTransactionNotificationsLoop();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        leading: AgriNetLogo(),
        title: UserScreenAppBarDrawer(),
      ),
      body: Stack(
        children: [
          context.watch<IndexBloc>().state == 0
              ? ProductPostsList()
              : NotificationsScreen(),
          CollapsingSideBarDrawer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (this.transactionProvider != null) {
      this.transactionProvider!.stopLoop();
    }
    if (this.notificationProvider != null) {
      this.notificationProvider!.stopTransactionNotificationsLoop();
    }
  }
}
