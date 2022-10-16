class ShoeModel {
  String? name;
  String? collectionName;
  String? image;
  String? price;

  ShoeModel({
    this.name,
    this.price,
    required this.collectionName,
    required this.image,
  });
}

List<ShoeModel> listViewItems = [
  ShoeModel(collectionName: "Collection'22", image: 'assets/images/shoe_1.png'),
  ShoeModel(collectionName: "Cyber Neon'22", image: 'assets/images/shoe_2.png'),
  ShoeModel(collectionName: "Gradient Fade", image: 'assets/images/shoe_3.png'),
  ShoeModel(collectionName: "Ronaldo's Set", image: 'assets/images/shoe_4.png'),
  ShoeModel(collectionName: "LeBron's Set", image: 'assets/images/shoe_5.png'),
];

List<ShoeModel> gridViewItems = [
  ShoeModel(
    collectionName: "Ronaldo's Set",
    image: 'assets/images/shoe_4.png',
    name: 'Nike Air Max 2090',
    price: '229.19 \$',
  ),
  ShoeModel(
    collectionName: "LeBron's Set",
    image: 'assets/images/shoe_5.png',
    name: 'Nike Air Force 1',
    price: '140.00 \$',
  ),
  ShoeModel(
    collectionName: "Cyber Neon'22",
    image: 'assets/images/shoe_2.png',
    name: 'Nike Air Max 1',
    price: '160.00 \$',
  ),
  ShoeModel(
    collectionName: "Collection'22",
    image: 'assets/images/shoe_1.png',
    name: 'Nike Air Max 3',
    price: '236.00 \$',
  ),
  ShoeModel(
    collectionName: "Gradient Fade",
    image: 'assets/images/shoe_3.png',
    name: 'Nike Air Max 90',
    price: '161.99 \$',
  ),
];
