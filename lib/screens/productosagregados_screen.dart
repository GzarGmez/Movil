import 'package:flutter/material.dart';

class ProductosAgregadosScreen extends StatefulWidget {
  @override
  _ProductosAgregadosScreenState createState() => _ProductosAgregadosScreenState();
}

class _ProductosAgregadosScreenState extends State<ProductosAgregadosScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _editarProducto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre del producto',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Precio del producto',
                ),
              ),
              // Agrega más campos según sea necesario
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                // Aquí puedes agregar la lógica para guardar los cambios
                Navigator.of(context).pop();
              },
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
        title: Text('Productos Agregados'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Producto 1
              Card(
                child: Column(
                  children: [
                    // Agregar la imagen del producto
                    Container(
                      height: 200,
                      child: Image.asset('assets/images/camisa.png'),
                    ),
                    ListTile(
                      title: Text('Camiseta slim'),
                      subtitle: Text('Blanca\$299.00 MXN'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _editarProducto,
                          child: Text('Editar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Producto 2
              Card(
                child: Column(
                  children: [
                    // Agregar la imagen del producto
                    Container(
                      height: 200,
                      child: Image.asset('assets/images/gorra.png'),
                    ),
                    ListTile(
                      title: Text('Gorra básica'),
                      subtitle: Text('Negra\$149.00 MXN'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _editarProducto,
                          child: Text('Editar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
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
}