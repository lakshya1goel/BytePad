class UserModel {
  String? email;
  String? name;
  bool? isDepartmentHead;
  bool? isFaculty;
  bool? isStudent;
  String? userName;
  int? rollNumber;

  UserModel(
      {this.email,
        this.name,
        this.isDepartmentHead,
        this.isFaculty,
        this.isStudent,
        this.userName,
        this.rollNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    isDepartmentHead = json['is_department_head'];
    isFaculty = json['is_faculty'];
    isStudent = json['is_student'];
    userName = json['user_name'];
    rollNumber = json['roll_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['is_department_head'] = this.isDepartmentHead;
    data['is_faculty'] = this.isFaculty;
    data['is_student'] = this.isStudent;
    data['user_name'] = this.userName;
    data['roll_number'] = this.rollNumber;
    return data;
  }
}
