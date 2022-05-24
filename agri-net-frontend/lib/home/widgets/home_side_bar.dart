import '../../libs.dart';
import '../../theme.dart';

class CollapsingNavTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  // final Function onTap;
  final VoidCallback onTap;

  CollapsingNavTile(this.title, this.icon, this.animationController,
      this.isSelected, this.onTap);

  @override
  State<CollapsingNavTile> createState() => _CollapsingNavTileState();
}

class _CollapsingNavTileState extends State<CollapsingNavTile> {
  double maxWidth = 140;
  double minWidth = 40;
  late Animation<double> widthAnimation;
  late Animation<double> sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween(begin: maxWidth, end: minWidth)
        .animate(widget.animationController);
    sizedBoxAnimation =
        Tween(begin: 5.0, end: 0.0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.5)),
          color: widget.isSelected
              ? selectedListTileText
              : notSelectedListTileText,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 25,
              color: widget.isSelected
                  ? selectedListTileIcon
                  : notSelectedListTileIcon,
            ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= 120)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? listTileSelectedtextstyle
                        : listTileDefaulttextstyle,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
