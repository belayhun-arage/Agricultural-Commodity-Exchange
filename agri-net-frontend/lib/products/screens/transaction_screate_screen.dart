import 'package:flutter/services.dart';

import '../../libs.dart';

class CreateTransactionScreen extends StatefulWidget {
  static const String RouteName = "/transaction/create/screen";
  ProductPost post;
  CreateTransactionScreen(this.post, {Key? key}) : super(key: key);

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  String message =
      "fasklfjasldkfjalskdfjlasdjkflajsdfljasdfkljaskldfjalsdjflajsdflkajsdflajldfjasdkl";
  Color messageColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          translate(lang, "Request to buy"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            ProductItemSmallView(widget.post),
            CreateTransaction(widget.post),
          ],
        ),
      ),
    );
  }
}
