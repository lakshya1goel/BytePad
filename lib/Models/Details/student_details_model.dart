class StudentDetailsModel {
  String? email;
  String? name;
  String? profilePicture;
  bool? isDepartmentHead;
  bool? isFaculty;
  bool? isStudent;
  int? rollNumber;
  int? currentSemester;
  String? branch;
  int? contactNumber;
  String? dateOfBirth;
  String? guardianName;
  int? guardianContactNumber;

  StudentDetailsModel(
      {this.email,
        this.name,
        this.profilePicture,
        this.isDepartmentHead,
        this.isFaculty,
        this.isStudent,
        this.rollNumber,
        this.currentSemester,
        this.branch,
        this.contactNumber,
        this.dateOfBirth,
        this.guardianName,
        this.guardianContactNumber});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    isDepartmentHead = json['is_department_head'];
    isFaculty = json['is_faculty'];
    isStudent = json['is_student'];
    rollNumber = json['roll_number'];
    currentSemester = json['current_semester'];
    branch = json['branch'];
    contactNumber = json['contact_number'];
    dateOfBirth = json['date_of_birth'];
    guardianName = json['guardian_name'];
    guardianContactNumber = json['guardian_contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    data['is_department_head'] = this.isDepartmentHead;
    data['is_faculty'] = this.isFaculty;
    data['is_student'] = this.isStudent;
    data['roll_number'] = this.rollNumber;
    data['current_semester'] = this.currentSemester;
    data['branch'] = this.branch;
    data['contact_number'] = this.contactNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['guardian_name'] = this.guardianName;
    data['guardian_contact_number'] = this.guardianContactNumber;
    return data;
  }
}
