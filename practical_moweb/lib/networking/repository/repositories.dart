import 'dart:convert';

import 'package:practical_moweb/networking/api_provider.dart';
import 'package:practical_moweb/networking/models/getData/get_data_response.dart';
import 'package:practical_moweb/networking/models/postData/post_data_request.dart';
import 'package:practical_moweb/networking/models/postData/post_data_response.dart';
import 'package:practical_moweb/networking/networking_constants.dart';

class GetDataRepository {
  final ApiProvider _apiProvider = ApiProvider();
  Future<GetDataResponse> getData() async {
    final response = await _apiProvider.get(getDataUrl);
    return GetDataResponse.fromJson(response);
  }
}

class PostDataRepository {
  final ApiProvider _apiProvider = ApiProvider();
  Future<PostDataResponse> postData(PostDataRequest request) async {
    final response = await _apiProvider.post(postDataUrl,request);
    storage.write("productsFor${request.category_id}", jsonEncode(response).toString());
    return PostDataResponse.fromJson(response);
  }
}