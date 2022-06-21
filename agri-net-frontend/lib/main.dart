import 'package:flutter/services.dart';

import 'libs.dart';
import 'users/data_provider/admin_dataProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) =>
                UserBloc(repo: UserRepo(provider: AuthProvider())),
          ),
          BlocProvider(create: (context) {
            return AdminsBloc(
                adminsRepo: AdminsRepo(adminsProvider: AdminProvider()));
          }),
          BlocProvider(create: (context) {
            return ProductTypeBloc(
              ProductTypesRepository(ProductTypesProvider()),
            );
          }),
          BlocProvider(
            create: (context) {
              return StoreBloc(
                  storeRepo: StoreRepo(storeProvider: StoreProvider()));
            },
          ),
          BlocProvider(create: (context) {
            return MyProductsBloc(
              ProductsRepo(
                ProductProvider(),
              ),
            );
          }),
          BlocProvider(create: (context) {
            return IndexBloc();
          }),
          BlocProvider(create: (context) {
            return ProductsBloc(repo: ProductsRepo(ProductProvider()));
          }),
          BlocProvider(create: (context) {
            return UsersBloc(UsersRepo(UsersProvider()));
          }),
          BlocProvider(create: (context) {
            return TransactionBloc(TransactionRepo(TransactionProvider()));
          }),
          BlocProvider(create: (context) {
            return AdminsBloc(
                adminsRepo: AdminsRepo(adminsProvider: AdminProvider()));
          }),
          BlocProvider(create: (context) {
            return AgentsBloc(
                agentRepo: AgentRepo(agentProvider: AgentProvider()));
          }),
          BlocProvider(create: (context) {
            return MercahntsBloc(
                merchantRepo:
                    MerchantRepo(merchantProvider: MerchantProvider()));
          }),
          BlocProvider(create: (context) {
            return ProductTypeBloc(
              ProductTypesRepository(ProductTypesProvider()),
            );
          }),
          BlocProvider(
            create: (context) {
              return StoreBloc(
                  storeRepo: StoreRepo(storeProvider: StoreProvider()));
            },
          ),
          BlocProvider(create: (context) {
            return MyProductsBloc(
              ProductsRepo(
                ProductProvider(),
              ),
            );
          }),
          BlocProvider(create: (context) {
            return ProductsBloc(repo: ProductsRepo(ProductProvider()));
          }),
          BlocProvider(create: (context) {
            return NotificationsBloc(
              NotificationRepository(
                NotificationProvider(),
              ),
            );
          }),
        ],
        child: MyHomePage(),
      ),
    ),
  );
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agri-Net',
        theme: ThemeData(
          primaryColor: Colors.green, //  MaterialColor(primary, swatch),
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
          } else if (route == MerchantsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return MerchantsScreen();
            });
          } else if (route == AgentsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return AgentsScreen();
            });
          } else if (route == HomeScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return HomeScreen();
            });
          } else if (route == AdminsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return AdminsScreen();
            });
          } else if (route == TransactionDetailScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              Transaction transaction = ((setting.arguments
                  as Map<String, Transaction>)["transaction"] as Transaction);
              return TransactionDetailScreen(transaction);
            });
          } else if (route == CreateTransactionScreen.RouteName) {
            ProductPost post =
                (setting.arguments as Map<String, ProductPost>)["post"]!;
            return MaterialPageRoute(builder: (context) {
              return CreateTransactionScreen(post);
            });
          } else if (route == ConfirmationScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return ConfirmationScreen();
            });
          } else if (route == NotificationsScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return NotificationsScreen();
            });
          } else if (route == UserProfileScreen.RouteName) {
            User args = setting.arguments as User;
            return MaterialPageRoute(builder: (context) {
              return UserProfileScreen(
                requestedUser: args,
              );
            });
          } else if (route == UploadProductPostImages.RouteName) {
            ProductPost post =
                (setting.arguments as Map<String, dynamic>)["post"];
            return MaterialPageRoute(builder: (context) {
              return UploadProductPostImages(post);
            });
          } else if (route == StoreSelectionScreen.RouteName) {
            final arguments = setting.arguments as Map<String, dynamic>;
            // ProductTypeState state = (arguments["state"]) as ProductTypeState;
            List<Store> stores = arguments["stores"] as List<Store>;
            Function callBack = (arguments["callback"] as Function);
            return MaterialPageRoute(builder: (context) {
              return StoreSelectionScreen(stores, callBack);
            });
          } else if (route == ProductPostDetailScreen.RouteName) {
            final ProductPost post = ((setting.arguments
                as Map<String, dynamic>)["post"] as ProductPost);
            return MaterialPageRoute(builder: (context) {
              return ProductPostDetailScreen(post);
            });
          } else if (route == ProductTypeSelectionScreen.RouteName) {
            final arguments = setting.arguments as Map<String, dynamic>;
            ProductTypeState state = (arguments["state"]) as ProductTypeState;
            List<ProductType> products =
                arguments["products"] as List<ProductType>;
            Function callBack = (arguments["callback"] as Function);
            String text = (arguments["text"] as String);

            return MaterialPageRoute(builder: (context) {
              return ProductTypeSelectionScreen(
                  state, products, callBack, text);
            });
          } else if (route == MyStoresScreen.RouteName) {
            return MaterialPageRoute(builder: (context) {
              return MyStoresScreen();
            });
          }
        });
  }
}
