class Product{
  late String productId;
  late String productName;
  late String productImage;
  late String size;
  late String specialPrice;
  late String mainPrice;
  late String cateName;
  bool isAdded = false;

  Product(this.productId, this.productName, this.productImage, this.size, this.specialPrice, this.mainPrice, this.cateName, this.isAdded);

  Product.fromMap(Map map) {
    productId = map[productId];
    productName = map[productName];
    productImage = map[productImage];
    size = map[size];
    specialPrice = map[specialPrice];
    mainPrice = map[mainPrice];
    cateName = map[cateName];
    isAdded = false;
  }
}