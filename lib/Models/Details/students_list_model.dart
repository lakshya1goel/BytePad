class StudentsListModel {
  String? userName;
  int? rollNumber;
  String? profilePic;

  StudentsListModel({this.userName, this.rollNumber, this.profilePic});

  StudentsListModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    rollNumber = json['roll_number'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['roll_number'] = this.rollNumber;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
