class VerifyOTPResponse {
  String? detail;
  String? token;

  VerifyOTPResponse({this.detail, this.token});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['token'] = this.token;
    return data;
  }
}