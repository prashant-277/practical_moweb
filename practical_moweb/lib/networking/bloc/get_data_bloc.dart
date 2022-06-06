import 'dart:async';

import 'package:practical_moweb/networking/models/getData/get_data_response.dart';
import 'package:practical_moweb/networking/repository/repositories.dart';

import '../response.dart';

class GetDataBloc {
  late GetDataRepository getDataRepository;
  late StreamController getDataBlocController;

  StreamSink get dataSink => getDataBlocController.sink;
  Stream get stream => getDataBlocController.stream;

  GetDataBloc() {
    getDataBlocController = StreamController();
    getDataRepository = GetDataRepository();
  }

  getDataBlocMethod() async {
    dataSink.add(ResponseStatic.loading('getting data ...'));
    try {
      GetDataResponse response =await getDataRepository.getData();
      print(response);
      dataSink.add(ResponseStatic.completed(response));
    } catch (e) {
      dataSink.add(ResponseStatic.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    getDataBlocController.close();
  }
}
