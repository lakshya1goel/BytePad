class PaperListingModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  PaperListingModel({this.count, this.next, this.previous, this.results});

  PaperListingModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? file;
  int? year;
  int? semester;
  List<String>? courses;

  Results(
      {this.id, this.title, this.file, this.year, this.semester, this.courses});

  Results.fromJson(Map<String, dynamic> json) {
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
