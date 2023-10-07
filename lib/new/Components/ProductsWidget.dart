import 'package:flutter/material.dart';
import 'package:shakosh/new/Components/ProductCard.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/ProductModel.dart';

// ignore: must_be_immutable
class ProductsWidget extends StatelessWidget {
  ProductsWidget({super.key, required this.products, this.crossAxisCount});

  final List<ProductModel> products;
  int? crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mySize(10, 10, 30, 30, 30)!),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mySize(260, 260, 300, 320, 310),
            crossAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            mainAxisSpacing: mySize(10, 10, 20, 20, 20)!,
            crossAxisCount: crossAxisCount ?? mySize(2, 2, 3, 4, 5)!.toInt(),
          ),
          itemCount: products.length,
          itemBuilder: (context, i) {
            ProductModel product = products[i];
            return ProductCard(
              product: product,
            );
          }),
    );
  }
}