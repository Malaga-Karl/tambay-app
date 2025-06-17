import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/models/shared_pref.dart';
import 'package:tambay/service/cart_service.dart';
import 'package:tambay/service/specific_product_service.dart';

class SpecificScreen extends StatefulWidget {
  final int id;

  const SpecificScreen({super.key, required this.id});

  @override
  State<SpecificScreen> createState() => _SpecificScreenState();
}

class _SpecificScreenState extends State<SpecificScreen> {
  Item? item;
  int quantity = 1;
  bool isLoading = true;
  late int variantIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    final fetchedItem = await SpecificProductService().fetchItem(widget.id);
    setState(() {
      item = fetchedItem;
      isLoading = false;
    });
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    if (isLoading || item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(57, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    item!.image.src,
                    width: deviceWidth * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                item!.title,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                "PHP ${item!.variants[variantIndex].price}",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.left,
              ),
              Visibility(
                visible: item!.variants.length > 1,
                child: SegmentedButton<String>(
                  segments:
                      item!.variants.map((variant) {
                        return ButtonSegment<String>(
                          value: variant.title,
                          label: Text(variant.title),
                        );
                      }).toList(),
                  selected: <String>{item!.variants[variantIndex].title},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      variantIndex = item!.variants.indexWhere(
                        (v) => v.title == newSelection.first,
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text("Quantity"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: quantity > 1 ? _decrementQuantity : null,
                        icon: Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: TextEditingController(
                            text: quantity.toString(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            final numValue = int.tryParse(value) ?? 1;
                            if (numValue > 0) {
                              setState(() {
                                quantity = numValue;
                              });
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: _incrementQuantity,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Add the item to the cart using the cart service
                    await CartService().saveCartItem(
                      item!.id,
                      SharedPref(item: item!, quantity: quantity),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added ${item!.title} to cart")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to add to cart: $e")),
                    );
                  }
                },
                child: Text("Add to Cart"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
