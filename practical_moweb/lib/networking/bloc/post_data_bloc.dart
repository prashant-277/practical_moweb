import 'dart:async';
import 'package:practical_moweb/networking/models/postData/post_data_request.dart';
import 'package:practical_moweb/networking/models/postData/post_data_response.dart';
import 'package:practical_moweb/networking/networking_constants.dart';
import 'package:practical_moweb/networking/repository/repositories.dart';
import 'package:practical_moweb/networking/response.dart';

class PostDataBloc {
  late PostDataRepository postDataRepository;
  late StreamController postDataBlocController;

  StreamSink get dataSink => postDataBlocController.sink;

  Stream get stream => postDataBlocController.stream;

  PostDataBloc() {
    postDataBlocController = StreamController();
    postDataRepository = PostDataRepository();
  }

  postDataBlocMethod(PostDataRequest request) async {
    dataSink.add(ResponseStatic.loading('posting data ...'));
    try {
      PostDataResponse response = await postDataRepository.postData(request);
      print(response);
      dataSink.add(ResponseStatic.completed(response));
      storage.write("listOfPost", response.response);
    } catch (e) {
      dataSink.add(ResponseStatic.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    postDataBlocController.close();
  }
}
