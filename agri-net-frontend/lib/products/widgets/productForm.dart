import '../../libs.dart';

class ProductFormScreen extends StatefulWidget {
  static String RouteName = "products/post";
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextField(),
          )
        ],
      ),
    );
  }
}
