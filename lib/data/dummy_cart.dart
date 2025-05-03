import 'package:tambay/models/item.dart';

List<Item> dummyCartItems = [
  Item(
    id: 1,
    name: "T-Shirt",
    price: 20.00,
    description: "A comfortable cotton t-shirt available in various colors.",
    imageUrl:
        "https://cdn.logojoy.com/wp-content/uploads/20230824145637/hiking-business-t-shirt-design-idea.jpg",
    isFeatured: true,
  ),
  Item(
    id: 2,
    name: "Jeans",
    price: 50.00,
    description: "Classic blue denim jeans with a slim fit.",
    imageUrl:
        "https://inspiring.tonello.com/wp-content/uploads/2024/03/EGO_HIGH-scaled-e1711469471518.jpg",
  ),
  Item(
    id: 3,
    name: "Jacket",
    price: 100.00,
    description: "A stylish leather jacket for all seasons.",
    imageUrl: "https://m.media-amazon.com/images/I/61HknRN0TcL._AC_SL1500_.jpg",
  ),
];

List<Item> dummyCartItemsEmpty = [];