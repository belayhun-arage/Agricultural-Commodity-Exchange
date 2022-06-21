import "../../libs.dart";

class AmendKebd extends StatefulWidget {
  const AmendKebd({Key? key}) : super(key: key);

  @override
  State<AmendKebd> createState() => _AmendKebdState();
}

class _AmendKebdState extends State<AmendKebd> {
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
              translate(lang, "Request Kebd"),
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
