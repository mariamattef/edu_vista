import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class LectureWidget extends StatefulWidget {
  const LectureWidget({super.key, this.lectures, required this.onLectureChosen

      // , this.course
      });
  final List<Lecture>? lectures;
  final void Function(Lecture) onLectureChosen;
  // final Course? course;

  @override
  State<LectureWidget> createState() => _LectureWidgetState();
}

class _LectureWidgetState extends State<LectureWidget> {
  bool isLoading = false;
  Lecture? selectedLecture;
  @override
  Widget build(BuildContext context) {
    // print(widget.course?.id); /////// Nul
    //////////
    ///////////
    //////
    ///😥😥😏
    //////////////////
    //////////////
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (widget.lectures == null || (widget.lectures!.isEmpty)) {
      return const Center(
        child: Text('No lectures found'),
      );
    } else {
      return GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(widget.lectures!.length, (index) {
          return InkWell(
            onTap: () {
              widget.onLectureChosen(widget.lectures![index]);
              selectedLecture = widget.lectures![index];
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: selectedLecture?.id == widget.lectures![index].id
                    ? ColorUtility.deepYellow
                    : const Color(0xffE0E0E0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lecture ${index + 1}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: selectedLecture?.id ==
                                    widget.lectures![index].id
                                ? Colors.white
                                : Colors.black),
                      ),
                      Icon(Icons.file_download_outlined,
                          color:
                              selectedLecture?.id == widget.lectures![index].id
                                  ? Colors.white
                                  : Colors.black),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.lectures![index].title ?? 'No Name',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: selectedLecture?.id == widget.lectures![index].id
                            ? Colors.white
                            : Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.lectures![index].describtion ?? 'No description',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: selectedLecture?.id == widget.lectures![index].id
                            ? Colors.white
                            : Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Duration: ${widget.lectures![index].duration} min',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: selectedLecture?.id ==
                                      widget.lectures![index].id
                                  ? Colors.white
                                  : Colors.black)),
                      Icon(
                        Icons.play_circle_outline,
                        size: 35,
                        color: selectedLecture?.id == widget.lectures![index].id
                            ? Colors.white
                            : Colors.black,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      );
    }
  }
}
