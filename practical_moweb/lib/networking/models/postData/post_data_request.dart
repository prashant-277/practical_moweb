class PostDataRequest {
  String? category_id;

  PostDataRequest({this.category_id});

  PostDataRequest.fromJson(Map<String, dynamic> json) {
    category_id = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = category_id;
    return data;
  }
}
