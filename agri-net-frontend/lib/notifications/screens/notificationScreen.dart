import "../../libs.dart";

class NotificationsScreen extends StatefulWidget {
  static const RouteName = "/notification/routes";
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(

          // height: 100,
          // width: 100,
          // color: Theme.of(context).primaryColor,
          child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          margin: EdgeInsets.only(
            left: 40,
            top: 0,
            bottom: 0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: selectedIndex == 0
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          translate(lang, " My Transactions "),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: selectedIndex == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.transfer_within_a_station_rounded,
                          color: selectedIndex == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    " | ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: selectedIndex == 1
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          translate(lang, " Transactions "),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: selectedIndex == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.translate,
                          color: selectedIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    " | ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: selectedIndex == 2
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          translate(lang, " Kebd "),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: selectedIndex == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.transfer_within_a_station_rounded,
                          color: selectedIndex == 2
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    " | ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: selectedIndex == 3
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          translate(lang, " Guarantee "),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: selectedIndex == 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.transfer_within_a_station_rounded,
                          color: selectedIndex == 3
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ---------------------------------------

        selectedIndex == 0 ? TransactionsList() : SizedBox()
      ])),
    );
  }
}
