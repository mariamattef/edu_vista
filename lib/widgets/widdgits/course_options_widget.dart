import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enum.dart';
import 'package:edu_vista/widgets/widdgits/certificate_widget.dart';
import 'package:edu_vista/widgets/download_widget.dart';
import 'package:edu_vista/widgets/widdgits/lecture_widget.dart';
import 'package:edu_vista/widgets/more_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final Lecture? lectures;
  final void Function(Lecture) onLectureChosen;

  const CourseOptionsWidgets({
    required this.courseOption,
    required this.course,
    required this.onLectureChosen,
    super.key,
    this.lectures,
  });

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  Lecture? selectedLecture;
  List<Lecture>? lectures;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200), () async {});
    if (!mounted) return;
    lectures = await context.read<CourseBloc>().getLectures();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void getCertificatetion(context, Course course) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CertificateWidget(course: course);
      },
    );
  }

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.Lecture:
        return LectureWidget(
            lectures: lectures,
            onLectureChosen: (Lecture) {
              widget.lectures;
            });

      case CourseOptions.Download:
        return DownloadWidget(
          lectures: lectures,
          onLectureChosen: (Lecture) {
            widget.lectures;
          },
        );

      case CourseOptions.Certificate:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getCertificatetion(context, widget.course);
        });
        return const SizedBox.shrink();

      case CourseOptions.More:
        MoreWidget(
          course: widget.course,
        );

      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
    return const SizedBox.shrink();
  }
}
