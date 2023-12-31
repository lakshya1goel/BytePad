class SolutionListingModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  SolutionListingModel({this.count, this.next, this.previous, this.results});

  SolutionListingModel.fromJson(Map<String, dynamic> json) {
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
  int? paper;
  String? file;

  Results({this.id, this.paper, this.file});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paper = json['paper'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paper'] = this.paper;
    data['file'] = this.file;
    return data;
  }
}
