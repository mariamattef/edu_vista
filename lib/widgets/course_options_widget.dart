import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enum.dart';
import 'package:edu_vista/widgets/certificate_widget.dart';
import 'package:edu_vista/widgets/download_widget.dart';
import 'package:edu_vista/widgets/lecture_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = true;
      });
    });

    await Future.delayed(const Duration(microseconds: 1200), () async {});
    if (!mounted) return;
    lectures = await context.read<CourseBloc>().getLectures();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      setState(() {
        isLoading = false;
      });
    });
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
    print(widget.course.id);
    switch (widget.courseOption) {
      case CourseOptions.Lecture:
        return LectureWidget(
            lectures: lectures, onLectureChosen: widget.onLectureChosen);
      case CourseOptions.Download:
        return DownloadWidget(
            lectures: lectures, onLectureChosen: widget.onLectureChosen);

      case CourseOptions.Certificate:
        return CertificateWidget(course: widget.course);

      case CourseOptions.More:
        return MoreWidget(
          course: widget.course,
        );

      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
