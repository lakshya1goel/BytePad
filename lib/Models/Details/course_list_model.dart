class CourseListModel {
  int? count;
  String? next;
  Null? previous;
  List<Results>? results;

  CourseListModel({this.count, this.next, this.previous, this.results});

  CourseListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? courseCode;
  String? name;

  Results({this.courseCode, this.name});

  Results.fromJson(Map<String, dynamic> json) {
    courseCode = json['course_code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_code'] = this.courseCode;
    data['name'] = this.name;
    return data;
  }
}
