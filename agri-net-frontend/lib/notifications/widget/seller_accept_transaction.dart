import "../../libs.dart";

class SellerAcceptTransaction extends StatefulWidget {
  const SellerAcceptTransaction({Key? key}) : super(key: key);

  @override
  State<SellerAcceptTransaction> createState() => _SellerAcceptTransactionState();
}

class _SellerAcceptTransactionState extends State<SellerAcceptTransaction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Text(
              translate(lang, "Seller Accept Transaction"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
