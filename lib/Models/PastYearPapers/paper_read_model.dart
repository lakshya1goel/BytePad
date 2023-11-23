class PaperReadModel {
  int? id;
  String? title;
  String? file;
  int? year;
  int? semester;
  List<String>? courses;

  PaperReadModel(
      {this.id, this.title, this.file, this.year, this.semester, this.courses});

  PaperReadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    file = json['file'];
    year = json['year'];
    semester = json['semester'];
    courses = json['courses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['file'] = this.file;
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['courses'] = this.courses;
    return data;
  }
}
