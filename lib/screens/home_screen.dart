import 'package:flutter/material.dart';
import 'detalle_screen.dart'; // Asegúrate de ajustar el nombre del proyecto
import 'jugueteria_screen.dart'; // Importa la pantalla de Juguetería
import 'perfil_screen.dart'; // Importa la pantalla de Perfil
import 'busqueda_screen.dart'; // Importa la pantalla de Búsqueda
import 'carrito_screen.dart'; // Importa la pantalla de Carrito
import 'productosagregados_screen.dart'; // Importa la pantalla de Productos Agregados

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    routes: {
      '/busqueda': (context) => BusquedaScreen(),
      '/perfil': (context) => PerfilScreen(), // Asegúrate de tener esta pantalla definida
      '/carrito': (context) => CarritoScreen(), // Ruta para la pantalla del carrito
      '/productosagregados': (context) => ProductosAgregadosScreen(), // Ruta para la pantalla de Productos Agregados
    },
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
        // Mantenerse en la pantalla de inicio
          break;
        case 1:
        // Navegar a la pantalla del carrito
          Navigator.pushNamed(context, '/carrito'); // Navegar a '/carrito'
          break;
        case 2:
        // Navegar a la pantalla de perfil
          Navigator.pushNamed(context, '/perfil'); // Navegar a '/perfil'
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF5FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Acción al presionar el menú
          },
        ),
        title: Row(
          children: [
            Image.asset('assets/images/Logo.png', height: 70),
            const SizedBox(width: 60),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/busqueda');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(56.0),
              child: Image.asset('assets/images/promo.png'), // Imagen principal de promoción
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 16), // Añadimos un espacio inicial
                  CategoryItem(
                    icon: Icons.toys,
                    label: 'Juguetería',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JugueteriaScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 16), // Espacio entre categorías
                  CategoryItem(
                    icon: Icons.devices,
                    label: 'Productos agregados',
                    onTap: () {
                      Navigator.pushNamed(context, '/productosagregados');
                    },
                  ),
                  const SizedBox(width: 16), // Espacio entre categorías
                  CategoryItem(icon: Icons.local_grocery_store, label: 'Super mercado', onTap: () {}),
                  const SizedBox(width: 16), // Espacio entre categorías
                  CategoryItem(icon: Icons.wine_bar, label: 'Vinos y Licores', onTap: () {}),
                  const SizedBox(width: 16), // Espacio entre categorías
                  CategoryItem(icon: Icons.local_pharmacy, label: 'Farmacia', onTap: () {}),
                  const SizedBox(width: 16), // Espacio final
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Ordenar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Filtrar'),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ProductItem(
                          image: 'assets/images/camisa.png',
                          name: 'Camiseta slim',
                          price: '\$299.00 MXN',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(Icons.shopping_cart, size: 32.0, color: Colors.black),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ProductItem(
                          image: 'assets/images/gorra.png',
                          name: 'Gorra básica',
                          price: '\$199.00 MXN',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(Icons.shopping_cart, size: 32.0, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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

  PerfilScreen() {}
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30),
          ),
          const SizedBox(height: 20),
          Text(label),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              image: image,
              name: name,
              price: price,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(color: Colors.purple)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}