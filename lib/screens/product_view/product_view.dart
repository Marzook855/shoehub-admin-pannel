import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/models/product_model/product_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/product_view/add_product/add_product.dart';
import 'package:admin_panel/screens/product_view/widgets/single_product_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products  View"),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const AddProduct(), context: context);
            },
            icon: const Icon(Icons.add_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Products",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: appProvider.getProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.9,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct = appProvider.getProducts[index];
                    return SingleProductView(
                      singleProduct: singleProduct,
                      index: index,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
