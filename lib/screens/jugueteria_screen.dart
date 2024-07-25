import 'package:flutter/material.dart';

class JugueteriaScreen extends StatefulWidget {
  @override
  _JugueteriaScreenState createState() => _JugueteriaScreenState();
}

class _JugueteriaScreenState extends State<JugueteriaScreen> {
  int _selectedIndex = 0;

  final List<Product> products = [
    Product(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Peluche chico',
      color: 'Blanco',
      price: 99.00,
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

  void _showEditProductDialog(Product product) {
    TextEditingController nameController = TextEditingController(text: product.name);
    TextEditingController colorController = TextEditingController(text: product.color);
    TextEditingController priceController = TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: colorController,
                decoration: InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  product.name = nameController.text;
                  product.color = colorController.text;
                  product.price = double.tryParse(priceController.text) ?? product.price;
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juguetería'),
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
          return GestureDetector(
            onTap: () {
              _showEditProductDialog(products[index]);
            },
            child: ProductCard(product: products[index]),
          );
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
  String imageUrl;
  String name;
  String color;
  double price;

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
      child: Stack(
        children: [
          Column(
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
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.shopping_cart, size: 32.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
