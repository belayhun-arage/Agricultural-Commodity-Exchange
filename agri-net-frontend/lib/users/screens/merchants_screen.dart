import '../../libs.dart';

class MerchantsScreen extends StatefulWidget {
  static String RouteName = "/merchants/screen";
  const MerchantsScreen({Key? key}) : super(key: key);

  @override
  State<MerchantsScreen> createState() => _MerchantsScreenState();
}

class _MerchantsScreenState extends State<MerchantsScreen> {
  bool merchantsList = true;
  PageController pageController = PageController();

  void callMeBro() {
    pageController.previousPage(
      duration: Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          merchantsList ? " Merchants " : " Create Merchant ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text(
                "New",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(ProductForm.RouteName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (merchantsList) {
            pageController.nextPage(
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            );
          } else {
            pageController.previousPage(
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            );
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: Icon(
          merchantsList ? Icons.add : Icons.list,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Container(
        child: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              if (val == 0) {
                merchantsList = true;
              } else {
                merchantsList = false;
              }
            });
          },
          children: [MerchantsList(), MerchantInstanceForm(callMeBro)],
        ),
      ),
    );
  }
}
