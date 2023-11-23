class StudentAttendanceDataModel {
  List<AttendanceRecords>? attendanceRecords;
  int? present;
  int? absent;
  int? totalClasses;
  dynamic totalAttendance;
  List<CourseWise>? courseWise;

  StudentAttendanceDataModel(
      {this.attendanceRecords,
        this.present,
        this.absent,
        this.totalClasses,
        this.totalAttendance,
        this.courseWise});

  StudentAttendanceDataModel.fromJson(Map<String, dynamic> json) {
    if (json['attendance_records'] != null) {
      attendanceRecords = <AttendanceRecords>[];
      json['attendance_records'].forEach((v) {
        attendanceRecords!.add(new AttendanceRecords.fromJson(v));
      });
    }
    present = json['present'];
    absent = json['absent'];
    totalClasses = json['total_classes'];
    totalAttendance = json['total_attendance'];
    if (json['course_wise'] != null) {
      courseWise = <CourseWise>[];
      json['course_wise'].forEach((v) {
        courseWise!.add(new CourseWise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendanceRecords != null) {
      data['attendance_records'] =
          this.attendanceRecords!.map((v) => v.toJson()).toList();
    }
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['total_classes'] = this.totalClasses;
    data['total_attendance'] = this.totalAttendance;
    if (this.courseWise != null) {
      data['course_wise'] = this.courseWise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceRecords {
  String? date;
  String? courseName;
  String? courseCode;
  List<AttendanceRecords>? attendanceRecords;

  AttendanceRecords(
      {this.date, this.courseName, this.courseCode, this.attendanceRecords});

  AttendanceRecords.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    courseName = json['course_name'];
    courseCode = json['course_code'];
    if (json['attendance_records'] != null) {
      attendanceRecords = <AttendanceRecords>[];
      json['attendance_records'].forEach((v) {
        attendanceRecords!.add(new AttendanceRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['course_name'] = this.courseName;
    data['course_code'] = this.courseCode;
    if (this.attendanceRecords != null) {
      data['attendance_records'] =
          this.attendanceRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceData {
  bool? present;

  AttendanceData({this.present});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    return data;
  }
}

class CourseWise {
  String? subject;
  int? present;
  int? absent;
  double? percent;

  CourseWise({this.subject, this.present, this.absent, this.percent});

  CourseWise.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    present = json['present'];
    absent = json['absent'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['percent'] = this.percent;
    return data;
  }
}
