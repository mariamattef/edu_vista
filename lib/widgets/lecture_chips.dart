import 'package:edu_vista/utils/app_enum.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class LectureChipsWidget extends StatefulWidget {
  final CourseOptions? selectedOption;
  final void Function(CourseOptions) onChanged;
  const LectureChipsWidget(
      {this.selectedOption, required this.onChanged, super.key});

  @override
  State<LectureChipsWidget> createState() => _LectureChipsWidgetState();
}

class _LectureChipsWidgetState extends State<LectureChipsWidget> {
  List<CourseOptions> chips = [
    CourseOptions.Lecture,
    CourseOptions.Download,
    CourseOptions.Certificate,
    CourseOptions.More
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        separatorBuilder: (ctx, index) => const SizedBox(
          width: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              widget.onChanged(chips[index]);
            },
            child: _ChipWidget(
              isSelected: chips[index] == widget.selectedOption,
              label: chips[index].name,
            ),
          );
        },
      ),
    );
  }
}

class _ChipWidget extends StatelessWidget {
  final bool isSelected;
  final String label;
  const _ChipWidget({required this.isSelected, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      padding: const EdgeInsets.all(8),
      side: BorderSide.none,
      shape: const StadiumBorder(),
      backgroundColor:
          isSelected ? ColorUtility.deepYellow : ColorUtility.grayExtraLight,
      label: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, fontSize: 17),
      ),
      // color:
    );
  }
}
