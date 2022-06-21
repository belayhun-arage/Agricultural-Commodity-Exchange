import "../../libs.dart";

class RequestKebdAmendment extends StatefulWidget {
  const RequestKebdAmendment({Key? key}) : super(key: key);

  @override
  State<RequestKebdAmendment> createState() => _RequestKebdAmendmentState();
}

class _RequestKebdAmendmentState extends State<RequestKebdAmendment> {
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
              translate(lang, "Request Kebd Amendment"),
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
