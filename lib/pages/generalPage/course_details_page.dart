import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/blocs/lecture/lecture_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/course_options_widget.dart';
import 'package:edu_vista/widgets/video_box_widget.dart';
import 'package:edu_vista/widgets/lecture_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsPage extends StatefulWidget {
  static const String id = 'course_details';
  final Course course;
  const CourseDetailsPage({required this.course, super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  void initState() {
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    context.read<LectureBloc>().add(LectureEventInitial());

    super.initState();
  }

  bool applyChanges = false;

  void toggleApplyChanges() {
    setState(() {
      if (!applyChanges) {
        applyChanges = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocConsumer<LectureBloc, LectureState>(listener: (ctx, state) {
          if (state is LectureChosenState) {
            toggleApplyChanges();
          }
        }, builder: (ctx, state) {
          var stateEx = state is LectureChosenState ? state : null;
          print('>>>>>>>>>>${stateEx?.lecture.lecture_url}');

          if (stateEx == null) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 250,
            child: stateEx.lecture.lecture_url == null ||
                    stateEx.lecture.lecture_url == ''
                ? const Center(
                    child: Text(
                    'Invalid Url',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
                : VideoBoxWidget(
                    url: stateEx.lecture.lecture_url ?? '',
                  ),
          );
        }),
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              duration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
              // height: MediaQuery.sizeOf(context).height - 220,
              height:
                  applyChanges ? MediaQuery.sizeOf(context).height - 220 : null,
              curve: Curves.easeInOut,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.course.title ?? 'No Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.course.instructor?.name ?? 'No Instructor Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const _BodyWidget()
                    ],
                  ),
                ),
              ),
            )),
        Positioned(
          top: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorUtility.main,
            ),
          ),
        ),
      ],
    ));
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({super.key});

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CourseBloc, CourseState>(builder: (ctx, state) {
        return Column(
          children: [
            LectureChipsWidget(
              selectedOption: (state is CourseOptionStateChanges)
                  ? state.courseOption
                  : null,
              onChanged: (courseOption) {
                context
                    .read<CourseBloc>()
                    .add(CourseOptionChosenEvent(courseOption));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: (state is CourseOptionStateChanges)
                  ? CourseOptionsWidgets(
                      course: context.read<CourseBloc>().course!,
                      courseOption: state.courseOption,
                      onLectureChosen: (lecture) {
                        context
                            .read<LectureBloc>()
                            .add(LectureChosenEvent(lecture));
                      })
                  : const SizedBox.shrink(),
            )
          ],
        );
      }),
    );
  }
}
