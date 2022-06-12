import 'package:practical_moweb/localDB/helper/dbhelper.dart';
import 'package:practical_moweb/localDB/model/product.dart';
import 'package:practical_moweb/networking/bloc/post_data_bloc.dart';
import 'package:practical_moweb/networking/models/postData/post_data_request.dart';
import 'package:practical_moweb/networking/networking_constants.dart';
import 'package:practical_moweb/networking/models/postData/post_data_response.dart';
import 'package:practical_moweb/networking/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_moweb/ui/ExtraPages/extra_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PostDataScreen extends StatefulWidget {
  var productName;
  var productId;

  PostDataScreen(this.productName, this.productId, {Key? key})
      : super(key: key);

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  late PostDataBloc postDataBloc;
  bool isLoading = false;
  late PostDataResponse postDataResponse;
  late String apiError;

  //bool gotResponse = false;
  List allItemList = [];
  List searchItemList = [];
  String searchKey = "";
  int item = 1;
  var dbHelper = DBHelper();
  int data = 1;

  internetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('Yes! Internet working!');
    } else {
      dbHelper.getProduct(widget.productName).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            allItemList = value;
          });
        } else {
          data = 0;
        }
        return value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    internetConnectivity();

    postDataBloc = PostDataBloc();
    postDataBloc.stream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.loading:
            isLoading = true;
            break;
          case Status.completed:
            postDataResponse = event.data;
            var stringProductResponse =
                storage.read("productsFor${widget.productId}");
            allItemList =
                postDataResponseFromJson(stringProductResponse).response;
            isLoading = false;

            for (int i = 0; i <= allItemList.length; i++) {
              var product = Product(
                  allItemList[i].id,
                  allItemList[i].productName,
                  baseUrl + allItemList[i].productImage[0],
                  allItemList[i].size,
                  allItemList[i].specialPrice.toString(),
                  allItemList[i].mainPrice.toString(),
                  widget.productName.toString(),
                  allItemList[i].isAdded);
              dbHelper.saveProduct(product);
              setState(() {});
            }
            //gotResponse = true;
            break;
          case Status.error:
            apiError = event.message;
            print(apiError);
            isLoading = false;
            break;
        }
      });
    });
    postDataBloc
        .postDataBlocMethod(PostDataRequest(category_id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
              Text(widget.productName,
                  style: const TextStyle(color: Colors.black)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_basket_outlined,
                      color: Colors.black))
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchKey = value;
                      searchItemList = [];
                      allItemList.forEach((element) {
                        if (element.productName
                            .toLowerCase()
                            .contains(searchKey.toLowerCase())) {
                          searchItemList.add(element);
                        }
                      });
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search by product name or brand name',
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey, size: 30),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2.0)),
                  )),
            ),
            Expanded(
              child: isLoading ? buildLoader() : buildBodyWithList(),
            ),
            bottomWidget()
          ],
        ),
      ),
    );
  }

  buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  buildBodyWithList() {
    if (data == 1) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount:
            searchKey.isNotEmpty ? searchItemList.length : allItemList.length,
        itemBuilder: (context, index) {
          //bool isAdded = true;
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ExtraPage()));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          FadeInImage.memoryNetwork(
                            height: MediaQuery.of(context).size.height / 9,
                            imageErrorBuilder: (c, o, st) {
                              return Container(
                                color: Colors.grey,
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.width / 4,
                              );
                            },
                            placeholder: kTransparentImage,
                            image: searchKey.isNotEmpty
                                ? baseUrl +
                                    searchItemList[index].productImage[0]
                                : baseUrl + allItemList[index].productImage[0],
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${searchKey.isNotEmpty ? searchItemList[index].productName : allItemList[index].productName}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text(
                                      "${searchKey.isNotEmpty ? searchItemList[index].size : allItemList[index].size}"),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${searchKey.isNotEmpty ? double.parse(searchItemList[index].specialPrice.toString()) < double.parse(searchItemList[index].mainPrice.toString()) ? searchItemList[index].mainPrice : '' : double.parse(allItemList[index].specialPrice.toString()) < double.parse(allItemList[index].mainPrice.toString()) ? double.parse(allItemList[index].mainPrice.toString()) : ''}",
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${searchKey.isNotEmpty ? searchItemList[index].specialPrice : allItemList[index].specialPrice}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    Colors.deepOrangeAccent)),
                                        allItemList[index].isAdded
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                height: 30.0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        width: 1),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (item == 1) {
                                                                allItemList[index]
                                                                        .isAdded =
                                                                    false;
                                                              } else {
                                                                item--;
                                                              }
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.remove,
                                                              size: 15,
                                                              color: Colors
                                                                  .deepOrangeAccent)),
                                                      Text(item.toString(),
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .deepOrangeAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            item++;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                            Icons.add,
                                                            size: 15,
                                                            color: Colors
                                                                .deepOrangeAccent),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                height: 30.0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: RaisedButton(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .deepOrangeAccent)),
                                                    onPressed: () {
                                                      setState(() {
                                                        allItemList[index]
                                                            .isAdded = true;
                                                        print(index);
                                                      });
                                                    },
                                                    color: Colors.white,
                                                    textColor:
                                                        Colors.deepOrangeAccent,
                                                    child: const Text("Add",
                                                        style: TextStyle(
                                                            fontSize: 15))))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(thickness: 2)
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
          child: const Center(
              child: Text("No Internet", style: TextStyle(fontSize: 20))));
    }
  }

  bottomWidget() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: const [
              Icon(Icons.height),
              Text("Sort"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              color: Colors.grey,
              height: 40,
              width: 1,
            ),
          ),
          Row(
            children: const [Icon(Icons.filter_alt_outlined), Text("Filter")],
          )
        ],
      ),
    );
  }
}
