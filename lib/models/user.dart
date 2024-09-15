class User {
  String? profile_Picture;
  String? name;
  String? phone;
  String? adress;

  User.fromJson(Map<String, dynamic> data) {
    profile_Picture = data['profile_Picture'];
    name = data['name'];
    phone = data['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_Picture'] = profile_Picture;
    data['name'] = name;
    data['email'] = phone;
    return data;
  }
}
