import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';
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
    int variantCount = item!.variants.length;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item!.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PHP ${item!.variants[variantIndex].price}",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
