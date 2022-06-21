import "../../libs.dart";

class AuthScreen extends StatefulWidget {
  static const String RouteName = "auth_screen";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  int index = 1;
  void changeWidget() {
    if (index == 1) {
      pageController.animateToPage(index + 1,
          duration: Duration(seconds: 2), curve: Curves.elasticOut);
      index = 2;
    } else if (index == 2) {
      pageController.previousPage(
          duration: Duration(seconds: 2), curve: Curves.elasticOut);
      index = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.white,
                      color: Colors.lightGreen,

                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(300, 100)),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(190, 100)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                style: BorderStyle.none,
                                width: 0,
                                color: Colors.grey),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.95,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.only(top: 60),
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: (MediaQuery.of(context).size.width > 1000)
                                  ? (MediaQuery.of(context).size.width * 0.3)
                                  : (MediaQuery.of(context).size.width * 0.8),
                              child: Center(
                                child: Card(
                                  elevation: 5,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: PageView(
                                        children: [
                                          LoginWidget(changeWidget, context),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  color: Colors.white,
                                ),
                                child: new Image.asset(
                                  'assets/images/logo.jpg',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            top: 0,
                            left: MediaQuery.of(context).size.width * 0.35 - 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
