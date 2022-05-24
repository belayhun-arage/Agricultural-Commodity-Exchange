import 'package:agri_net_frontend/admins/widgets/register_admin_form.dart';

import 'libs.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
              repo: AuthRepo(provider: AuthProvider()),
            )),
    BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(userRepo: UserRepo(userProvider: UserProvider())),
    ),
    BlocProvider(create: (context) {
      return AdminsBloc(
          adminsRepo: AdminsRepo(adminsProvider: AdminsProvider()))
        ..add(GetAllAdminsEvent());
    }),
    BlocProvider(create: (context) {
      return ProductBloc(
        repo: ProductRepo(provider: ProductProvider()),
      )..add(GetProductListEvent());
    }),
  ], child: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  // static int once = 0;
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // if (MyHomePage.once == 0) {
    //   context.read<AdminsBloc>().add(GetAllUsersEvent());
    //   MyHomePage.once++;
    // }
    return MaterialApp(
        title: 'Agri-Net',
        theme: ThemeData(
          primaryColor: Colors.green, //  MaterialColor(primary, swatch),
          canvasColor: Colors.white,
        ),
        initialRoute: AuthScreen.RouteName,
        onGenerateRoute: (setting) {
          final route = setting.name;
          if (route == AuthScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return AuthScreen();
            });
          } else if (route == ProductScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return ProductScreen();
            });
          } else if (route == ProfileScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            });
          } else if (route == RegisteredMerchantsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return RegisteredMerchantsScreen();
            });
          }
          // else if (route == ContractScreen.RouteName) {
          //   return MaterialPageRoute(builder: (context) {
          //     return ContractScreen();
          //   });
          // } else if (route == NotificationScreen.RouteName) {
          //   return MaterialPageRoute(builder: (context) {
          //     return NotificationScreen();
          //   });
          // }
          else if (route == HomeScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return HomeScreen();
            });
          } else if (route == AdminsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return AdminsScreen();
            });
          } else if (route == RegisterAdminPage.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return RegisterAdminPage();
            });
          }
        });
  }
}
