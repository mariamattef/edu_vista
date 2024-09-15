import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ExpansionTileWidget extends StatefulWidget {
  const ExpansionTileWidget({
    super.key,
    this.course,
    required this.titleTile,
    required this.body,
    this.icons,
  });
  final Course? course;
  final String titleTile;
  final List<Widget> body;
  final icons;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        isExpanded = value;
        setState(() {});
      },
      collapsedBackgroundColor: ColorUtility.grayExtraLight,
      backgroundColor: ColorUtility.gbScaffold,
      textColor: ColorUtility.deepYellow,
      iconColor: ColorUtility.deepYellow,
      shape: const Border.fromBorderSide(BorderSide.none),
      collapsedShape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isExpanded
              ? Border.all(
                  color: ColorUtility.deepYellow,
                )
              : null,
        ),
        child: Row(
          children: [
            Text(
              widget.titleTile,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              isExpanded ? widget.icons : widget.icons,
            )
          ],
        ),
      ),
      showTrailingIcon: false,
      childrenPadding: const EdgeInsets.all(0),
      children: widget.body,
    );
  }
}
