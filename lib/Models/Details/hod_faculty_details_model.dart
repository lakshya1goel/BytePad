class HodFacultyDetailsModel {
  String? email;
  String? name;
  String? profilePicture;
  bool? isDepartmentHead;
  bool? isFaculty;
  bool? isStudent;
  String? user;
  int? contactNumber;
  String? dateOfBirth;
  String? department;

  HodFacultyDetailsModel(
      {this.email,
        this.name,
        this.profilePicture,
        this.isDepartmentHead,
        this.isFaculty,
        this.isStudent,
        this.user,
        this.contactNumber,
        this.dateOfBirth,
        this.department});

  HodFacultyDetailsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    isDepartmentHead = json['is_department_head'];
    isFaculty = json['is_faculty'];
    isStudent = json['is_student'];
    user = json['user'];
    contactNumber = json['contact_number'];
    dateOfBirth = json['date_of_birth'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    data['is_department_head'] = this.isDepartmentHead;
    data['is_faculty'] = this.isFaculty;
    data['is_student'] = this.isStudent;
    data['user'] = this.user;
    data['contact_number'] = this.contactNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['department'] = this.department;
    return data;
  }
}
