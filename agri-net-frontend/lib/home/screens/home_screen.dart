import '../../libs.dart';

class HomeScreen extends StatefulWidget {
  static const String RouteName = "homescreen";
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: ((context, state) {
      if (state is UserLoggedInState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            toolbarHeight: MediaQuery.of(context).size.height / 13,
            elevation: 5,
            leading: AgriNetLogo(),
            title: UserScreenAppBarDrawer(user: state.user),
          ),
          body: CollapsingSideBarDrawer(),
        );
      }
      return AuthScreen();
    }));
  }
}
