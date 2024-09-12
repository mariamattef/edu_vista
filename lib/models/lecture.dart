class Lecture {
  String? id;
  String? title;
  String? describtion;
  int? duration;
  String? lecture_url;
  int? sort;
  List<String>? watched_users;
  Lecture(
    this.id,
    this.title,
    this.describtion,
    this.duration,
    this.lecture_url,
    this.sort,
    this.watched_users,
  );
  Lecture.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    describtion = data['describtion'];
    duration = data['duration'];
    lecture_url = data['lecture_url'];
    sort = data['sort'];
    watched_users =
        data['watched_users'] != null ? List.from(data['watched_users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id as String;
    data['title'] = title as String;
    data['describtion'] = describtion as String;
    data['duration'] is String
        ? int.tryParse(data['duration'] as String)
        : data['duration'] as int?;
    data['lecture_url'] = lecture_url;
    data['sort'] = sort;
    data['watched_users'] = watched_users;
    return data;
  }
}
