import '../../libs.dart';
import '../../theme.dart';

class CollapsingSideBarDrawer extends StatefulWidget {
  CollapsingSideBarDrawer();

  @override
  State<CollapsingSideBarDrawer> createState() =>
      _CollapsingSideBarDrawerState();
}

class _CollapsingSideBarDrawerState extends State<CollapsingSideBarDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 140;
  double minWidth = 40;
  bool isSideBarExpanded = false;
  late AnimationController animationController;
  late Animation<double> widthAnimation;
  int currentSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    widthAnimation =
        Tween(begin: maxWidth, end: minWidth).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, widget) {
            return getWidget(context, widget);
          }),
    );
  }

  Widget getWidget(context, widget) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    final sideBarlItems = (StaticDataStore.ROLE == ROLE_ADMIN ||
            StaticDataStore.ROLE == ROLE_INFOADMIN)
        ? adminSideBarItems
        : (StaticDataStore.ROLE == ROLE_AGENT)
            ? agentSideBarItems
            : (StaticDataStore.ROLE == ROLE_MERCHANT)
                ? merchantSideBarItems
                : (StaticDataStore.ROLE == ROLE_SUPERADMIN)
                    ? superAdminSideBarItems
                    : [];
    Widget divider;
    return Container(
      width: widthAnimation.value,
      color: sideBarBackgroundColor,
      child: Column(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                setState(() {
                  isSideBarExpanded = !isSideBarExpanded;
                  isSideBarExpanded
                      ? animationController.forward()
                      : animationController.reverse();
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: animationController,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, counter) {
              if (counter == sideBarlItems.length - 3) {
                divider = Divider(
                  height: 200,
                );
              } else {
                divider = Container();
              }
              return Column(
                children: [
                  CollapsingNavTile(
                      sideBarlItems[counter].title,
                      sideBarlItems[counter].icon,
                      animationController,
                      currentSelectedIndex == counter, () {
                    setState(() {
                      currentSelectedIndex = counter;
                      Navigator.pushNamed(context, sideBarlItems[counter].path);
                    });
                  }),
                  divider
                ],
              );
            },
            itemCount: sideBarlItems.length,
          )),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimationController>(
        'animationController', animationController));
  }
}
