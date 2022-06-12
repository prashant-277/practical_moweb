import 'package:flutter/material.dart';
import 'package:practical_moweb/localDB/model/product.dart';
import 'package:practical_moweb/networking/bloc/get_data_bloc.dart';
import 'package:practical_moweb/networking/networking_constants.dart';
import 'package:practical_moweb/ui/postDataScreen/post_data_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'networking/bloc/post_data_bloc.dart';
import 'networking/models/getData/get_data_response.dart';
import 'networking/response.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late GetDataBloc getDataBloc;
  //is loading variable is not used when we use future builder but in normal api calls to manage loading it is necessary
  bool isLoading = false;
  GetDataResponse? getDataResponse;
  late String apiError;

  ValueNotifier<List<CategoryList>> itemList = ValueNotifier([]);
  List<CategoryList> allItemList = [];

  late PostDataBloc postDataBloc;

  void initState() {
    super.initState();
    getDataBloc = GetDataBloc();
    postDataBloc = PostDataBloc();
    getDataBloc.getDataBlocMethod();
    getDataBloc.stream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.loading:
            isLoading = true;
            break;
          case Status.completed:
            getDataResponse = event.data;
            itemList.value = event.data!.response.categoryList;
            allItemList = itemList.value;
            isLoading = false;
            print(event);
            break;
          case Status.error:
            apiError = event.message;
            print(apiError);
            isLoading = false;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepOrangeAccent,
        ),
        home: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.black)),
                    const Text("Shop by Category",
                        style: TextStyle(color: Colors.black)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_basket_outlined,
                            color: Colors.black))
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.white),
            body: isLoading || getDataResponse == null
                ? buildLoader()
                : buildBodyWithList()));
  }

  buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  buildBodyWithList() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: itemList.value.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: (3 / 4)),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostDataScreen(
                          allItemList[index].category.toString(),
                          allItemList[index].id)));
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                    vertical: BorderSide(width: 0.5, color: Colors.black12),
                    horizontal: BorderSide(width: 0.5, color: Colors.black12)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Center(
                      child: FadeInImage.memoryNetwork(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 8,
                        placeholder: kTransparentImage,
                        image: baseUrl + allItemList[index].imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(allItemList[index].category.toString(),
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// This class is for remove the ScrollGlow
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
