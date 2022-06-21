import "../../libs.dart";

class BuyerAcceptTransaction extends StatefulWidget {
  const BuyerAcceptTransaction({Key? key}) : super(key: key);

  @override
  State<BuyerAcceptTransaction> createState() => _BuyerAcceptTransactionState();
}

class _BuyerAcceptTransactionState extends State<BuyerAcceptTransaction> {
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
              translate(lang, "Buyer Accept Transaction"),
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
