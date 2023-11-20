class MyCollectionsPaperListModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  MyCollectionsPaperListModel(
      {this.count, this.next, this.previous, this.results});

  MyCollectionsPaperListModel.fromJson(Map<String, dynamic> json) {
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
  String? year;
  String? semester;
  List<String>? courses;
  int? paper;

  Results(
      {this.id,
        this.title,
        this.year,
        this.semester,
        this.courses,
        this.paper});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    semester = json['semester'];
    courses = json['courses'].cast<String>();
    paper = json['paper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['courses'] = this.courses;
    data['paper'] = this.paper;
    return data;
  }
}
