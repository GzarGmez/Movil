import 'package:flutter/material.dart';

class BusquedaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BusquedaScreenStateful();
  }
}

class BusquedaScreenStateful extends StatefulWidget {
  @override
  _BusquedaScreenState createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreenStateful> {
  int _selectedIndex = 0;

  final List<Product> products = [
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Camiseta slim',
      color: 'Blanca',
      price: 299.00,
    ),
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Camiseta regular',
      color: 'Negra',
      price: 399.00,
    ),
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Camiseta Normal',
      color: 'Negra',
      price: 399.00,
    ),
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Camiseta regular',
      color: 'Negra',
      price: 399.00,
    ),
    // Agrega más productos aquí
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Acción para el botón de búsqueda
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 10, // Espacio horizontal entre las columnas
          mainAxisSpacing: 10, // Espacio vertical entre las filas
          childAspectRatio: 0.75, // Relación de aspecto de los elementos de la cuadrícula
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String color;
  final double price;

  Product({
    required this.imageUrl,
    required this.name,
    required this.color,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(product.name),
            subtitle: Text(product.color),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${product.price.toStringAsFixed(2)} MXN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

