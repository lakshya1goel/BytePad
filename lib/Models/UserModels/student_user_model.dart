class StudentUserModel {
  String? email;
  String? name;
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

  StudentUserModel({
    this.email,
    this.name,
    this.isDepartmentHead,
    this.isFaculty,
    this.isStudent,
    this.rollNumber,
    this.currentSemester,
    this.branch,
    this.contactNumber,
    this.dateOfBirth,
    this.guardianName,
    this.guardianContactNumber,
  });

  StudentUserModel.fromJson(Map<String, dynamic> json) {
      email: json['email'];
      name: json['name'];
      isDepartmentHead: json['is_department_head'];
      isFaculty: json['is_faculty'];
      isStudent: json['is_student'];
      rollNumber: json['roll_number'];
      currentSemester: json['current_semester'];
      branch: json['branch'];
      contactNumber: json['contact_number'];
      dateOfBirth: json['date_of_birth'];
      guardianName: json['guardian_name'];
      guardianContactNumber: json['guardian_contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['isDepartmentHead'] = isDepartmentHead;
    data['isFaculty'] = isFaculty;
    data['isStudent'] = isStudent;
    data['rollNumber'] = rollNumber;
    data['currentSemester'] = currentSemester;
    data['branch'] = branch;
    data['contactNumber'] = contactNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['guardianName'] = guardianName;
    data['guardianContactNumber'] = guardianContactNumber;
    return data;
  }
}

