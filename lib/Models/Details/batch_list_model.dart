class BatchListModel {
  int? id;
  String? name;
  int? year;
  int? semester;
  String? branch;

  BatchListModel({this.id, this.name, this.year, this.semester, this.branch});

  BatchListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    semester = json['semester'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['branch'] = this.branch;
    return data;
  }
}
