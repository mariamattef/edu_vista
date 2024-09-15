import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ExpansionTileWidget extends StatefulWidget {
  const ExpansionTileWidget({
    super.key,
    this.course,
    required this.titleTile,
    required this.body,
    this.Icons,
  });
  final Course? course;
  final String titleTile;
  final List<Widget> body;
  final Icons;

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
      shape: const BeveledRectangleBorder(
          side: BorderSide(color: ColorUtility.deepYellow)),
      collapsedShape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(
        widget.titleTile,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        isExpanded ? widget.Icons : widget.Icons,
      ),
      childrenPadding: const EdgeInsets.all(10),
      children: widget.body,
    );
  }
}
//      ? Icons.keyboard_double_arrow_down_outlined
//             : Icons.double_arrow_outlined,