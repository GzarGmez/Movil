// lib/screens/product_detail_page.dart

import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
final String image;
final String name;
final String price;

const ProductDetailPage({
Key? key,
required this.image,
required this.name,
required this.price,
}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: const Color(0xFFEAF5FF),
elevation: 0,
leading: IconButton(
icon: const Icon(Icons.arrow_back),
onPressed: () {
Navigator.pop(context);
},
),
title: const Text('Producto'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
Image.asset(image),
const SizedBox(height: 16),
Text(
name,
style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Text(
price,
style: const TextStyle(fontSize: 20, color: Colors.black),
),
const SizedBox(height: 16),
Row(
children: [
IconButton(
icon: const Icon(Icons.favorite_border),
onPressed: () {
// Acción para agregar a favoritos
},
),
const Spacer(),
IconButton(
icon: const Icon(Icons.add_shopping_cart),
onPressed: () {
// Acción para agregar al carrito
},
),
],
),
],
),
),
);
}
}