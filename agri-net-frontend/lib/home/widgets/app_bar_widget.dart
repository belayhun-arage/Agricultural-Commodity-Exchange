import '../../libs.dart';

class UserScreenAppBarDrawer extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  State<UserScreenAppBarDrawer> createState() => _UserScreenAppBarDrawerState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _UserScreenAppBarDrawerState extends State<UserScreenAppBarDrawer> {
  int selectedLang = 0;
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    Widget divider;
    return Container(
      width: we,
      height: he / 11.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(child: LanguageDropDown()),
                SizedBox(
                  width: 30,
                ),
                UserAccountePage(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget LanguageDropDown() {
    return DropdownButton(
        value: selectedLang,
        items: [
          DropdownMenuItem(
            child: Text(
              "Amh",
            ),
            value: 0,
          ),
          DropdownMenuItem(
            child: Text(
              "Eng",
            ),
            value: 1,
          )
        ],
        onChanged: (int? value) {
          setState(() {
            value = value!;
          });
        });
  }
}
